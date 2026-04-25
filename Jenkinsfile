pipeline {
    agent any

    environment {
        APP_NAME        = 'my-devops-app'
        IMAGE_TAG       = "${BUILD_NUMBER}"
        DOCKER_IMAGE    = "${APP_NAME}:${IMAGE_TAG}"
        NEXUS_URL       = 'http://your-nexus-server:8081'
        NEXUS_REPO      = 'docker-hosted'
        SONAR_PROJECT   = 'my-devops-app'
        DEPLOY_SERVER   = 'your-deploy-server-ip'
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
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo '========== Stage: SonarQube Analysis =========='
                withSonarQubeEnv('SonarQube-Server') {
                    sh """
                        mvn sonar:sonar \
                            -Dsonar.projectKey=${SONAR_PROJECT} \
                            -Dsonar.projectName=${APP_NAME} \
                            -Dsonar.java.binaries=target/classes
                    """
                }
            }
        }

        stage('Quality Gate') {
            steps {
                echo '========== Stage: Quality Gate =========='
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Docker Build') {
            steps {
                echo '========== Stage: Docker Build =========='
                sh """
                    docker build -t ${DOCKER_IMAGE} .
                    docker tag ${DOCKER_IMAGE} ${NEXUS_URL}/${NEXUS_REPO}/${DOCKER_IMAGE}
                """
            }
        }

        stage('Push to Nexus') {
            steps {
                echo '========== Stage: Push to Nexus =========='
                withCredentials([usernamePassword(
                    credentialsId: 'NEXUS_CREDENTIALS',
                    usernameVariable: 'NEXUS_USER',
                    passwordVariable: 'NEXUS_PASS'
                )]) {
                    sh """
                        docker login ${NEXUS_URL} -u ${NEXUS_USER} -p ${NEXUS_PASS}
                        docker push ${NEXUS_URL}/${NEXUS_REPO}/${DOCKER_IMAGE}
                        docker logout ${NEXUS_URL}
                    """
                }
            }
        }

        stage('Deploy via Ansible') {
            steps {
                echo '========== Stage: Deploy via Ansible =========='
                withCredentials([sshUserPrivateKey(
                    credentialsId: 'ANSIBLE_SSH_KEY',
                    keyFileVariable: 'SSH_KEY'
                )]) {
                    sh """
                        ansible-playbook ansible/deploy.yml \
                            -i ansible/inventory.ini \
                            --private-key ${SSH_KEY} \
                            --extra-vars "image_tag=${IMAGE_TAG} app_name=${APP_NAME} nexus_url=${NEXUS_URL}"
                    """
                }
            }
        }

        stage('Health Check') {
            steps {
                echo '========== Stage: Health Check =========='
                sh "bash scripts/health-check.sh ${DEPLOY_SERVER}"
            }
        }
    }

    post {
        success {
            echo "========================================="
            echo " Pipeline SUCCESSFUL — Build #${BUILD_NUMBER}"
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
