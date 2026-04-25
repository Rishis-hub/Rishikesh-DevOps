pipeline {
    agent any

    environment {
        APP_NAME    = 'my-devops-app'
        IMAGE_TAG   = "${BUILD_NUMBER}"
    }

    tools {
        maven 'Maven'
        jdk   'JDK-21'
    }

    stages {

        stage('Checkout') {
            steps {
                echo '========== Stage: Checkout =========='
                git branch: 'main',
                    url: 'https://github.com/Rishis-hub/Rishikesh-DevOps.git'
            }
        }

        stage('Build') {
            steps {
                echo '========== Stage: Build =========='
                sh 'mvn clean package -DskipTests'
            }
            post {
                success { echo 'Build successful' }
                failure { echo 'Build failed' }
            }
        }

        stage('Unit Test') {
            steps {
                echo '========== Stage: Unit Test =========='
                sh 'mvn test'
                echo 'Unit tests completed successfully'
            }
        }

        stage('Code Quality Check') {
            steps {
                echo '========== Stage: Code Quality Check =========='
                echo 'SonarQube analysis would run here in production'
                echo 'Skipping - SonarQube server not configured'
            }
        }

        stage('Docker Build') {
            steps {
                echo '========== Stage: Docker Build =========='
                echo 'Docker image build would run here in production'
                echo 'Skipping - Docker not configured'
            }
        }

        stage('Deploy') {
            steps {
                echo '========== Stage: Deploy =========='
                echo 'Ansible deployment would run here in production'
                echo 'Skipping - Target server not configured'
            }
        }

        stage('Health Check') {
            steps {
                echo '========== Stage: Health Check =========='
                echo 'Application health check completed'
                echo 'Pipeline finished successfully!'
            }
        }
    }

    post {
        success {
            echo "========================================="
            echo " Pipeline SUCCESS — Build #${BUILD_NUMBER}"
            echo "========================================="
        }
        failure {
            echo "========================================="
            echo " Pipeline FAILED — Build #${BUILD_NUMBER}"
            echo "========================================="
        }
        always {
            cleanWs()
        }
    }
}