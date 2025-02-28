FROM tomcat:9-jdk17

LABEL maintainer="naveenkumars175"

# Copy the compiled WAR file into Tomcat's webapps directory
COPY target/Doc-Leap-app.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

