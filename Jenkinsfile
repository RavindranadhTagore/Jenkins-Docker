pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-node-app"
        DOCKERHUB_USER = "your-dockerhub-username"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh "docker build -t $IMAGE_NAME ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    script {
                        echo "Logging in to DockerHub..."
                        sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                        sh "docker tag $IMAGE_NAME $DOCKERHUB_USER/$IMAGE_NAME:latest"
                        sh "docker push $DOCKERHUB_USER/$IMAGE_NAME:latest"
                    }
                }
            }
        }

        stage('Deploy (Optional)') {
            steps {
                echo "Deploy stage - add your remote deploy commands here."
                // Example: sh "ssh user@server 'docker pull ... && docker run ...'"
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
