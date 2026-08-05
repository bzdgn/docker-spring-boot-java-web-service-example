# Use an official OpenJDK runtime as a parent image
FROM maven:3-jdk-8-alpine

# set shell to bash
# source: https://stackoverflow.com/a/40944512/3128926
RUN apk update && apk add bash

WORKDIR /sources

COPY * /sources

RUN cd /sources && mvn clean package

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run jar file when the container launches
CMD ["java", "-jar", "target/docker-java-app-example.jar"]
