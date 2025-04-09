pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'git@github.com:RavindranadhTagore/Jenkins.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build Angular App') {
            steps {
                sh 'npx ng build --configuration production'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying app...'
                // Example deployment step
                // Replace this with your actual deploy script (Firebase, SCP, Netlify, etc.)
                sh './deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Build or Deployment failed!'
        }
    }
}
