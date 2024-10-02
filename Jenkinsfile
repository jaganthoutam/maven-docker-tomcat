pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'SonarQube_Server'  // SonarQube server configured in Jenkins
        DOCKER_IMAGE = 'mytomcatapp'  // Name for the Docker image
    }

    stages {
        stage('Maven Build') {
            steps {
                echo 'Building Maven project...'
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube scan...'
                withSonarQubeEnv(SONARQUBE_SERVER) {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Deploy Docker Container') {
            steps {
                echo 'Deploying Docker container...'
                // Stop any existing container with the same name
                sh 'docker rm -f mytomcatapp || true'
                
                // Run a new Docker container using the created image
                sh 'docker run -d --name mytomcatapp -p 8080:8080 $DOCKER_IMAGE'
            }
        }

        stage('Deploy manifesty') {
            steps {
                echo 'Running SonarQube scan...'
                withSonarQubeEnv(SONARQUBE_SERVER) {
                    sh 'kubectly ap[ply -f path/'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()  // Clean the workspace after the build
        }
    }
}
