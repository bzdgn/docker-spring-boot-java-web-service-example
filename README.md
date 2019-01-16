Docker Container With Spring Boot Web Service Example
=====================================================
The aim is to demonstrate a running docker container with a spring boot standalone
web service thus, I've written the web service with Spring Boot as simple. For intensive
a complete web service example with Spring Boot, you can check out my other repository
which is [spring-boot-restful-web-service-example
](https://github.com/bzdgn/spring-boot-restful-web-service-example).

TOC
---
- [0 Spring Boot Web Service](#0-spring-boot-web-service) <br/>
- [1 Dockerfile](#1-dockerfile)
- [2 Building The Image](#2-building-the-image)
- [3 Running And Testing The Docker Container](#3-running-and-testing-the-docker-container)

0 Spring Boot Web Service
-------------------------
The web service we are using in this example is kept as simple as possible for the simplicity
of demonstrating how to run a docker container. It has a simple controller class which is quite
straight-forward as it is obvious: [HelloController](https://github.com/bzdgn/docker-spring-boot-java-web-service-example/blob/master/src/main/java/com/levo/dockerexample/controller/HelloController.java)

The key thing using a standalone Spring Boot application is to create a **Fat Jar**, also known as
**Uber Jar**. In order to create the **Uber Jar**, there are two things to be done;

- 1. Add an **start-class** to point to the class acting as the Entry Point as below;

```
    <properties>
        <start-class>com.levo.dockerexample.DockerApp</start-class>
    </properties>
```

In our example, you will see the properties as below in the [pom.xml](https://github.com/bzdgn/docker-spring-boot-java-web-service-example/blob/master/pom.xml) file.

```
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <java.version>1.8</java.version>
        <start-class>com.levo.dockerexample.DockerApp</start-class>
    </properties>
```

[Go back to TOC](#toc)


1 Dockerfile
------------

[Go back to TOC](#toc)


2 Building The Image
--------------------


[Go back to TOC](#toc)


3 Running And Testing The Docker Container
------------------------------------------


[Go back to TOC](#toc)




1- Maven install to create the fat jar

mvn clean install

2- Docker build

docker build --tag=docker-java-hello-world-app .

3- Docker run

docker run -p 80:8080 docker-java-hello-world-app

4- Test the app

http://localhost/docker-java-app/test

5- Get the container id

docker container ls

6- Get into the app

docker exec -it <container_id> /bin/bash

7- To stop the container

docker container stop <container_id>