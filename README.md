
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