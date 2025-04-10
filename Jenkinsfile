pipeline {
    agent any

    environment {
        // Define environment variables if needed
        DEPLOY_ENV = "production"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Building the application..."
                // Example for Node.js app
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
                sh 'npm test' // Adjust based on your test setup
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying the application..."
                // Example deployment command or script
                sh './deploy.sh' // Replace with your actual deployment logic
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check the logs."
        }
    }
}
