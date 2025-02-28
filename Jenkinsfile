pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'doc-leap-app'
        DOCKER_CONTAINER_NAME = 'doc-leap-container'
        CONTAINER_PORT = '8095'
    }

    stages {
        stage('Start') {
            steps {
                echo 'Starting Pipeline...'
            }
        }

        stage('Checkout SCM') {
            steps {
                git branch: 'main', credentialsId: 'github-credentials', url: 'https://github.com/naveenkumars175/Doc-leap-year.git'
            }
        }

        stage('Build WAR') {
            steps {
                sh '''
                    mkdir -p target
                    mkdir -p WEB-INF/classes
                    find src -name "*.java" | grep -q . && javac -d WEB-INF/classes $(find src -name "*.java")
                    jar -cvf target/Doc-Leap-app.war -C src/main/webapp .
                '''
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                sh 'sudo cp target/Doc-Leap-app.war /var/lib/tomcat9/webapps/'
            }
        }

        stage('Restart Tomcat') {
            steps {
                sh 'sudo systemctl restart tomcat9'
            }
        }

        stage('Docker Containerization') {
            steps {
                sh '''
                    echo "Building Docker image using legacy builder..."
                    docker build --no-cache -t ${DOCKER_IMAGE_NAME} .
                '''
            }
        }

        stage('Docker Deployment') {
            steps {
                sh '''
                    # Check if the container exists
                    if [ "$(docker ps -aq -f name=${DOCKER_CONTAINER_NAME})" ]; then
                        echo "Stopping and removing existing container..."
                        docker stop ${DOCKER_CONTAINER_NAME} || true
                        docker rm ${DOCKER_CONTAINER_NAME} || true
                    fi

                    # Run a new container
                    echo "Starting new Docker container..."
                    docker run -d -p ${CONTAINER_PORT}:8080 --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_NAME}
                '''
            }
        }
    }
}

