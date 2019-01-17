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
- [4 Getting Inside The Docker Container](#4-getting-inside-the-docker-container)
- [5 Stopping The Docker Container](#5-stopping-the-docker-container)
- [6 Cheat Sheet](#6-cheat-sheet)

0 Spring Boot Web Service
-------------------------
The web service we are using in this example is kept as simple as possible for the simplicity
of demonstrating how to run a docker container. It has a simple controller class which is quite
straight-forward as it is obvious: [HelloController](https://github.com/bzdgn/docker-spring-boot-java-web-service-example/blob/master/src/main/java/com/levo/dockerexample/controller/HelloController.java)

The key thing using a standalone Spring Boot application is to create a **Fat Jar**, also known as
**Uber Jar**. In order to create the **Uber Jar**, there are two things to be done;

1. Add an **start-class** to point to the class acting as the Entry Point as the example below.
The reason we are doing so is, we need to reference the **.jar** file in the [Dockerfile](https://github.com/bzdgn/docker-spring-boot-java-web-service-example/blob/master/Dockerfile);

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

2. The second thing is, we need to know the name of our **Fat Jar** (a.k.a. **Uber Jar**). In order
to do that, we use define the **final name** under **build** section of our [pom.xml](https://github.com/bzdgn/docker-spring-boot-java-web-service-example/blob/master/pom.xml) file as below;

```
    <build>
    	<finalName>docker-java-app-example</finalName>
    ...
    ...
    </build>
```

In our example, the build section is as below;

```
    <build>
    	<finalName>docker-java-app-example</finalName>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
```

As we create our **Fat Jar** (a.k.a. **Uber Jar**) and we define the final name of our jar,
we are all set and we can write the [Dockerfile](https://github.com/bzdgn/docker-spring-boot-java-web-service-example/blob/master/Dockerfile).

[Go back to TOC](#toc)


1 Dockerfile
------------
With the **Dockerfile** we can define, configure and initialize our image and container. In **Dockerfile** we can define;

1. Which image we are going to use. We need a docker image that has the OpenJDK and thus we are going to use Alpine;

```
	FROM openjdk:8-jre-alpine
```

2. Which shell we are going to have. I prefer **Bash** which I find easy to use;

```
	RUN apk update && apk add bash
```

3. The working directory our app is going to run. The name of the working directory will be **app**;

```
	WORKDIR /app
```

4. The files we need to copy into our image. We will need only the **Uber Jar** file so let's copy it into the working dir;

```
	COPY /target/docker-java-app-example.jar /app
```

5. The port number(s) that we need to expose to reach out from the container. Spring Boot default port is 8080;

```
	EXPOSE 8080
```

6. The commands that we need to run as the container goes live. And we need to add simply "java -jar <jar_file>.jar" format;

```
	CMD ["java", "-jar", "docker-java-app-example.jar"]
```

Notify that the CMD(command) parameters are separated with comma.

Then our **Dockerfile** will be as below;

```
	# Use an official OpenJDK runtime as a parent image
	FROM openjdk:8-jre-alpine
	
	# set shell to bash
	# source: https://stackoverflow.com/a/40944512/3128926
	RUN apk update && apk add bash
	
	# Set the working directory to /app
	WORKDIR /app
	
	# Copy the fat jar into the container at /app
	COPY /target/docker-java-app-example.jar /app
	
	# Make port 8080 available to the world outside this container
	EXPOSE 8080
	
	# Run jar file when the container launches
	CMD ["java", "-jar", "docker-java-app-example.jar"]
```

Now our [Dockerfile](https://github.com/bzdgn/docker-spring-boot-java-web-service-example/blob/master/Dockerfile) is all set, we can directly build the image.

[Go back to TOC](#toc)


2 Building The Image
--------------------
Before building the image, we need to create the **Uber Jar** (aka **Fat Jar**) file, to do so, just clean install with maven as below;

```
	mvn clean install
```

Now our **Uber Jar** file is created under the target folder with the format: "target/<final_name>.jar" (or .war based on package in .pom file)

To build the image, we will use **docker build** command and tag it. The last parameter will be the directory, by using dot ("."),
we point to the current directory. So you must run this command on the top level directory of this repository.

```
	docker build --tag=docker-java-hello-world-app .
```

As you run the command which is written above, a successful example output will be as below;

```
	C:\00_ANA\JavaEE\WS\docker-java-app-example>docker build --tag=docker-java-hello-world-app .
	Sending build context to Docker daemon  16.85MB
	Step 1/6 : FROM openjdk:8-jre-alpine
	 ---> 7e72a7dcf7dc
	Step 2/6 : RUN apk update && apk add bash
	 ---> Running in 66ebd9812836
	fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/APKINDEX.tar.gz
	fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/community/x86_64/APKINDEX.tar.gz
	v3.8.2-21-g54952ee375 [http://dl-cdn.alpinelinux.org/alpine/v3.8/main]
	v3.8.2-21-g54952ee375 [http://dl-cdn.alpinelinux.org/alpine/v3.8/community]
	OK: 9546 distinct packages available
	(1/5) Installing ncurses-terminfo-base (6.1_p20180818-r1)
	(2/5) Installing ncurses-terminfo (6.1_p20180818-r1)
	(3/5) Installing ncurses-libs (6.1_p20180818-r1)
	(4/5) Installing readline (7.0.003-r0)
	(5/5) Installing bash (4.4.19-r1)
	Executing bash-4.4.19-r1.post-install
	Executing busybox-1.28.4-r2.trigger
	OK: 91 MiB in 57 packages
	Removing intermediate container 66ebd9812836
	 ---> fa54653163af
	Step 3/6 : WORKDIR /app
	 ---> Running in c94cbad8627a
	Removing intermediate container c94cbad8627a
	 ---> 5a58ac387fe7
	Step 4/6 : COPY /target/docker-java-app-example.jar /app
	 ---> aa5930ee4a75
	Step 5/6 : EXPOSE 8080
	 ---> Running in 851b519d4514
	Removing intermediate container 851b519d4514
	 ---> 210ed5d1dc3f
	Step 6/6 : CMD ["java", "-jar", "docker-java-app-example.jar"]
	 ---> Running in 55b84275e095
	Removing intermediate container 55b84275e095
	 ---> a0c355a25236
	Successfully built a0c355a25236
	Successfully tagged docker-java-hello-world-app:latest
	SECURITY WARNING: You are building a Docker image from Windows against a non-Windows Docker host. All files and directories added to build context will have '-rwxr-xr-x' permissions. It is recommended to double check and reset permissions for sensitive files and directories.
```

After the image is built, you can check it with the ```docker image ls``` command. An example is as below;

```
	C:\00_ANA\JavaEE\WS\docker-java-app-example>docker image ls
	REPOSITORY                    TAG                 IMAGE ID            CREATED              SIZE
	docker-java-hello-world-app   latest              a0c355a25236        About a minute ago   105MB
	openjdk                       8-jre-alpine        7e72a7dcf7dc        5 days ago           83.1MB
```


[Go back to TOC](#toc)


3 Running And Testing The Docker Container
------------------------------------------
Now we have our docker image ready however, we need to run a container based on our image. We can simply run our docker container
as below;

```
	docker run -p 80:8080 docker-java-hello-world-app
```

The format is simple;

```
	docker run -p <external-port>:<internal-port> <image-name>
```

The parameter **p** stands for the **port**. **External port** is the port that will be available outside of the docker container.
The **internal port** is the port that will be available inside the docker container, which is **8080** because the default port of
Spring Boot is set to **8080**. So outside of the Docker Container, we will use the port number **80**, and it is mapped to **8080**
and will reach to the Spring Boot application.

As you run the command, you can open up your browser, you can go to this url [http://localhost:80/docker-java-app/test](http://localhost/docker-java-app/test)

Then you will see the container is returning the string message with date as below;

<p align="center">
	<img src="https://github.com/bzdgn/docker-spring-boot-java-web-service-example/blob/master/screenshots/00_docker_test.PNG" alt="docker-web-test">
</p>

[Go back to TOC](#toc)


4 Getting Inside The Docker Container
-------------------------------------
While our container is running, we can get inside the running container for different purposes like checking out the logging, configuration
and other stuff. Before getting inside the container, we need to know the **container id** of our container. To do so, let's first list
the running containers with the following command;

```
	docker container ls
```

A successful output example is as below;

```
C:\00_ANA\JavaEE\WS\docker-java-app-example>docker container ls
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS              PORTS                  NAMES
159c3ee8ef39        docker-java-hello-world-app   "java -jar docker-ja…"   7 minutes ago       Up 7 minutes        0.0.0.0:80->8080/tcp   adoring_jackson
```

You can see the container id on the left-most part of the output. For this example, the container id is "159c3ee8ef39". Each container will
have a different hash, so when you run it, it will be different. We are going to use this container id to get into the docker container as below;

```
	docker exec -it <container_id> /bin/bash
```

The "/bin/bash" at the end denotes that we are going to use **bash** shell, which our image has.

A successful output is as below;

```
	C:\00_ANA\JavaEE\WS\docker-java-app-example>docker exec -it 159c3ee8ef39 /bin/bash
	bash-4.4# pwd
	/app
	bash-4.4# ls
	docker-java-app-example.jar
	bash-4.4# ps -ef
	PID   USER     TIME  COMMAND
	    1 root      0:08 java -jar docker-java-app-example.jar
	   45 root      0:00 /bin/bash
	   53 root      0:00 ps -ef
	bash-4.4# exit
	exit
	
	C:\00_ANA\JavaEE\WS\docker-java-app-example>
```

As you can see, the commands "pwd", "ls" and "ps -ef" successfully ran. We can see that our jar file stand in the "app" folder
as we have configured in our Dockerfile. We can easily exit with the "exit" command.

[Go back to TOC](#toc)


5 Stopping The Docker Container
-------------------------------
To stop the docker container, we are going to use this command;

```
	docker stop <container_id>
```

It is as simple as that. Remember that when we ran the docker container, we have the Spring Boot output. I'm using windows while
writing this repository and if you hit ctrl+c, even if you are out of the scope of the logging output of Spring Boot, the container
is still alive. To stop it, you have to use the command above. A successful example is as below;

```
C:\00_ANA\JavaEE\WS\docker-java-app-example>docker container ls
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS              PORTS                  NAMES
159c3ee8ef39        docker-java-hello-world-app   "java -jar docker-ja…"   16 minutes ago      Up 16 minutes       0.0.0.0:80->8080/tcp   adoring_jackson

C:\00_ANA\JavaEE\WS\docker-java-app-example>docker container stop 159c3ee8ef39
159c3ee8ef39

C:\00_ANA\JavaEE\WS\docker-java-app-example>docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

C:\00_ANA\JavaEE\WS\docker-java-app-example>
```

[Go back to TOC](#toc)


6 Cheat Sheet
-------------


1. Maven install to create the fat jar

```
	mvn clean install
```

2. Docker build

```
	docker build --tag=docker-java-hello-world-app .
```

3. Docker run

```
	docker run -p 80:8080 docker-java-hello-world-app
```

4. Test the app

```
	http://localhost/docker-java-app/test
```

5. Get the container id

```
	docker container ls
```

6. Get into the app

```
	docker exec -it <container_id> /bin/bash
```

7. To stop the container

```
	docker container stop <container_id>
```


[Go back to TOC](#toc)