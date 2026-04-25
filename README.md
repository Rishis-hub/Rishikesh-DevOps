# Jenkins CI/CD Pipeline — Automated DevOps Project

A fully automated CI/CD pipeline using **Jenkins**, **Docker**, **Ansible**, **SonarQube**, and **Nexus** to streamline build, test, quality check, and deployment processes.

---

## 📌 Project Overview

This project demonstrates an end-to-end CI/CD pipeline that:
- Automatically triggers on every Git push
- Builds and tests the application
- Runs code quality analysis via SonarQube
- Packages and stores artifacts in Nexus
- Deploys to target server using Ansible

---

## 🏗️ Architecture

```
Developer → Git Push → Jenkins Trigger
                          ↓
                     Maven Build & Test
                          ↓
                     SonarQube Analysis
                          ↓
                     Docker Image Build
                          ↓
                     Push to Nexus/ECR
                          ↓
                     Ansible Deployment
                          ↓
                     Application Running
```

---

## 🛠️ Tools & Technologies

| Tool        | Purpose                        |
|-------------|-------------------------------|
| Jenkins     | CI/CD Orchestration            |
| Git/GitHub  | Source Code Management         |
| Maven       | Build & Dependency Management  |
| SonarQube   | Code Quality Analysis          |
| Docker      | Containerization               |
| Nexus       | Artifact Repository            |
| Ansible     | Configuration & Deployment     |
| AWS EC2     | Target Deployment Server       |

---

## 📁 Project Structure

```
jenkins-cicd-pipeline/
├── Jenkinsfile                  # Pipeline definition
├── Dockerfile                   # Container image build
├── pom.xml                      # Maven build config
├── ansible/
│   ├── deploy.yml               # Ansible deployment playbook
│   └── inventory.ini            # Target server inventory
├── app/
│   └── app.py                   # Sample Python application
├── scripts/
│   └── health-check.sh          # Post-deployment health check
└── README.md
```

---

## 🚀 How to Run

### Prerequisites
- Jenkins server with plugins: Git, Maven, Docker, Ansible, SonarQube Scanner
- SonarQube server running
- Nexus repository manager
- Target server with Ansible SSH access

### Steps

1. **Clone the repository**
```bash
git clone https://github.com/Rishis-hub/Rishikesh-DevOps.git
```

2. **Configure Jenkins**
   - Create a new Pipeline job in Jenkins
   - Set SCM to this GitHub repository
   - Jenkins will auto-detect the `Jenkinsfile`

3. **Add Jenkins Credentials**
   - `DOCKER_CREDENTIALS` — Docker Hub or ECR credentials
   - `NEXUS_CREDENTIALS` — Nexus username/password
   - `ANSIBLE_SSH_KEY` — Private key for target server
   - `SONAR_TOKEN` — SonarQube authentication token

4. **Trigger the pipeline**
   - Push any commit to `main` branch
   - Or manually click **Build Now** in Jenkins

---

## 📊 Pipeline Stages

| Stage              | Description                                      |
|--------------------|--------------------------------------------------|
| Checkout           | Pull latest code from GitHub                     |
| Build              | Compile and package using Maven                  |
| Unit Test          | Run JUnit tests                                  |
| SonarQube Analysis | Static code analysis and quality gate check      |
| Docker Build       | Build Docker image with version tag              |
| Push to Registry   | Push image to Nexus/ECR                          |
| Deploy             | Deploy to EC2 via Ansible playbook               |
| Health Check       | Verify application is running post-deployment    |

---

## 📈 Results Achieved

- Reduced manual deployment effort by **~40%**
- Deployment frequency increased from **weekly to daily**
- Automated quality gate prevents bad code from reaching production
- Zero-downtime deployments via rolling update strategy

---

## 👤 Author

**Rishikesh Rawate** — DevOps Engineer  
📧 rawaterishikesh@gmail.com  
🔗 [LinkedIn]www.linkedin.com/in/rishikesh-rawate-5097761a0
