pipeline {
    agent any
    environment {
        GIT_CREDENTIALS = 'github-credentials'
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
                    jar -cvf Doc-Leap-app.war *
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
                sh 'docker build -t doc-leap-app .'
            }
        }
        stage('Docker Deployment') {
            steps {
                sh '''
                    docker stop doc-leap-container || true
                    docker rm doc-leap-container || true
                    docker run -d -p 8090:8080 --name doc-leap-container doc-leap-app
                '''
            }
        }
    }
}

