pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ravindranadhtagore/-app'  // Replace with your Docker image name
        DOCKER_REGISTRY = 'docker.io'  // Use 'docker.io' for DockerHub
        DOCKER_CREDENTIALS = 'docker-hub-credentials'  // Jenkins credentials ID for Docker Hub
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📦 Cloning repository...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo '📥 Installing dependencies...'
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                echo '🏗️ Building application...'
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                script {
                    docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo '🔼 Pushing Docker image to DockerHub...'
                script {
                    docker.withRegistry('https://docker.io', "${DOCKER_CREDENTIALS}") {
                        docker.image("${DOCKER_IMAGE}:${BUILD_NUMBER}").push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying Docker image...'
                // Example: SSH into server and run docker commands to deploy the image
                sh '''
                    ssh user@your-server-ip "docker pull ${DOCKER_IMAGE}:${BUILD_NUMBER} && docker run -d -p 80:80 ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Build, Docker image creation, and deployment completed successfully!'
        }
        failure {
            echo '❌ Build failed. Check the logs.'
        }
    }
}
