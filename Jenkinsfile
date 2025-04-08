pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app"
        DOCKERHUB_USER = "ravindranadhtagore"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out code..."
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Login & Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    echo "Logging in to DockerHub and pushing image..."
                    sh '''
                        echo $PASSWORD | docker login -u $USERNAME --password-stdin
                        docker tag $IMAGE_NAME $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                        docker push $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                echo "Deploying application..."
                // Replace with your actual SSH and deployment command
                // Make sure SSH credentials are configured in Jenkins
                // Example: Pull latest image and restart container on remote server
                sh '''
                    ssh -o StrictHostKeyChecking=no user@your-server-ip "
                        docker pull $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG &&
                        docker stop my-app || true &&
                        docker rm my-app || true &&
                        docker run -d --name my-app -p 80:80 $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                    "
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful!"
        }
        failure {
            echo "❌ Deployment failed."
        }
    }
}
