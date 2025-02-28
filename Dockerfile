FROM tomcat:9-jdk17
LABEL maintainer="naveenkumars175"

# Deploy the WAR file
COPY Doc-Leap-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
