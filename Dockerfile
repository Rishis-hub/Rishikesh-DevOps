# ── Stage 1: Build ────────────────────────────────────────
FROM maven:3.8.6-openjdk-11 AS build

WORKDIR /app

# Copy pom.xml first for better layer caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source and build
COPY src ./src
RUN mvn clean package -DskipTests

# ── Stage 2: Run ──────────────────────────────────────────
FROM openjdk:11-jre-slim

WORKDIR /app

# Create non-root user for security best practice
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Copy built jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Set ownership
RUN chown appuser:appgroup app.jar

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
