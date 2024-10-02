# Use Amazon Corretto 17 as the base image for Java
FROM amazoncorretto:17

# Set environment variables for Tomcat
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Create necessary directories
RUN mkdir -p /opt/tomcat

# Install Tomcat 10.1.30 (the version you are using)
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.30/bin/apache-tomcat-10.1.30.tar.gz && \
    tar xzvf apache-tomcat-10.1.30.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm apache-tomcat-10.1.30.tar.gz

# Set permissions for Tomcat directories
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat && \
    chown -R tomcat:tomcat /opt/tomcat

# Expose the default Tomcat port
EXPOSE 8080

# Copy the WAR file from the target directory of the build to Tomcat webapps
COPY target/your-app.war $CATALINA_HOME/webapps/

# Switch to the Tomcat user
USER tomcat

# Start Tomcat
CMD ["catalina.sh", "run"]
