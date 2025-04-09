pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app"
        DOCKERHUB_USER = "ravindranadhtagore"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "🔄 Checking out code..."
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "🏗️ Building the application..."
                // Example build commands, adjust based on your tech stack
                // Node.js/Angular: `npm install`
                // Java Maven: `mvn clean package`
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo "🧪 Running tests..."
                // Replace this with your project's test command
                // For example: `npm test`, `ng test`, `mvn test`, etc.
                sh 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image..."
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    echo "📤 Pushing image to DockerHub..."
                    sh '''
                        echo $PASSWORD | docker login -u $USERNAME --password-stdin
                        docker tag $IMAGE_NAME $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                        docker push $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "🚀 Deploying the application..."
                // Example: Replace with actual SSH deployment
                // Make sure SSH credentials are set up in Jenkins
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
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check the logs for more info."
        }
    }
}
