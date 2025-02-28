pipeline {
    agent any
    environment {
        GIT_CREDENTIALS = 'github-credentials'
        DOCKER_CONTAINER_NAME = 'doc-leap-container'
        DOCKER_IMAGE_NAME = 'doc-leap-app'
        TOMCAT_PORT = '8090'   // Change this if needed
        CONTAINER_PORT = '8095' // Use a different port to avoid conflicts
    }
    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'main', credentialsId: "${GIT_CREDENTIALS}", url: 'https://github.com/naveenkumars175/Doc-leap-year.git'
            }
        }
        stage('Build WAR') {
            steps {
                sh '''
                    mkdir -p WEB-INF/classes
                    if find src -name "*.java" | grep -q .; then
                        find src -name "*.java" | xargs javac -cp /usr/share/tomcat9/lib/servlet-api.jar -d WEB-INF/classes
                    fi
                    jar -cvf Doc-Leap-app.war WEB-INF src/main/webapp
                '''
            }
        }
        stage('Deploy to Tomcat') {
            steps {
                sh 'sudo cp Doc-Leap-app.war /var/lib/tomcat9/webapps/'
            }
        }
        stage('Restart Tomcat') {
            steps {
                sh 'sudo systemctl restart tomcat9'
            }
        }
        stage('Docker Containerization') {
            steps {
                sh 'docker build --progress=plain -t ${DOCKER_IMAGE_NAME} .'
            }
        }
        stage('Docker Deployment') {
            steps {
                sh '''
                    # Check if the container exists (running or stopped)
                    if [ "$(docker ps -aq -f name=${DOCKER_CONTAINER_NAME})" ]; then
                        docker rm -f ${DOCKER_CONTAINER_NAME}
                    fi
                    
                    # Run the container on a different port to avoid conflicts
                    docker run -d -p ${CONTAINER_PORT}:8080 --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_NAME}
                '''
            }
        }
    }
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
    }
}

