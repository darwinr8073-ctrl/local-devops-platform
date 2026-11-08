pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t local-devops-app:latest -f app/Dockerfile app/'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                    docker rm -f local-devops-app || true
                    docker run -d --name local-devops-app -p 5000:5000 local-devops-app:latest
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'sleep 5 && curl -f http://localhost:5000'
            }
        }
    }

    post {
        success {
            echo 'Application deployed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check Console Output.'
        }
    }
}
