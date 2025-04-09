pipeline {
    agent any

    environment {
        // Optional environment variables
        NODE_ENV = 'production'
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

        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                sh 'npm test'
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying application...'
                // Replace this with your deployment command
                sh 'echo Deploy step (replace with real command)'
            }
        }
    }

    post {
        success {
            echo '✅ Build and deployment completed successfully!'
        }
        failure {
            echo '❌ Build failed. Check the logs.'
        }
    }
}
