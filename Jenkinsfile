pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', credentialsId: 'github-credentials', url: 'https://github.com/naveenkumars175/button-click-app.git'
            }
        }
        stage('Build WAR') {
            steps {
                sh 'mkdir -p build'
                sh 'jar -cvf build/button-click-app.war -C src/main/webapp .'
            }
        }
        stage('Deploy to Tomcat') {
            steps {
                sh 'sudo mv build/button-click-app.war /home/naveenkumar/tomcat9/webapps/'
            }
        }
        stage('Restart Tomcat') {
            steps {
                sh 'sudo /home/naveenkumar/tomcat9/bin/shutdown.sh || true'
                sh 'sudo /home/naveenkumar/tomcat9/bin/startup.sh'
            }
        }
    }
}

