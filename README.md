<div align="center">

<h3 align="center"><b><u>Deploy this project Instantly</u></b></h3>

<a href="https://launch.nife.io/deploy-app/start?repository-url=https://github.com/nifetency/docker-spring-boot-java-web-service-example.git">
  <img
    src="https://launch.nife.io/deploy-on-nife.svg"
    alt="Deploy on NIFE"
    width="280"
  />
</a>

</div>

# Docker Spring Boot Java Web Service Example

This repository contains a simple **Spring Boot** web service packaged with **Docker** and maintained as a deployment sample for **[Nife.io](https://nife.io)**.

It is designed as a lightweight example for developers who want to understand how to build a Java web service, package it into a Docker image, run it locally, and deploy it on **[Nife.io](https://nife.io)**.

## Overview

This project demonstrates a minimal Spring Boot application that can be built with Maven and containerized with Docker. It is intentionally small and easy to follow, which makes it useful as a reference project for local development, container workflows, and cloud deployment testing.

## Prerequisites

Before getting started, make sure the following tools are installed on your machine.

| Requirement | Purpose |
| --- | --- |
| Java | Required to build and run the Spring Boot application |
| Maven | Used to package the application |
| Docker | Used to build and run the container image |
| Git | Used to clone the repository |

## Getting Started

Clone the repository and move into the project directory.

```bash
git clone https://github.com/nifetency/docker-spring-boot-java-web-service-example.git
cd docker-spring-boot-java-web-service-example
```

Build the application with Maven.

```bash
mvn clean install
```

This command generates the packaged application artifact used in the Docker image build process.

## Run Locally with Docker

Build the Docker image from the repository root.

```bash
docker build -t docker-java-hello-world-app .
```

Run the container and map port `8080` from the container to your local machine.

```bash
docker run -p 8080:8080 docker-java-hello-world-app
```

After the container starts, you can test the service locally.

```bash
curl http://localhost:8080
```

If the application exposes a specific endpoint in your version of the project, you can also test that route directly.

## Docker Setup

The included `Dockerfile` packages the built Spring Boot application into a runnable Java container.

| Docker step | Purpose |
| --- | --- |
| Base image | Provides the Java runtime environment |
| Working directory | Sets the application path inside the container |
| Copy JAR | Adds the packaged application into the image |
| Expose port | Makes the service available on port `8080` |
| Start command | Runs the Spring Boot application with `java -jar` |

## Deploy on Nife.io

This repository can be used as a simple deployment sample on **[Nife.io](https://nife.io)**.

To deploy this project, create a new application on Nife.io, connect this GitHub repository, and use the repository `Dockerfile` as the build method.

| Setting | Suggested value |
| --- | --- |
| Source | Git Repository |
| Provider | GitHub |
| Repository | `nifetency/docker-spring-boot-java-web-service-example` |
| Internal Port | `8080` |
| External Port | `80` |
| Build Method | Dockerfile |

For step-by-step deployment guidance, see the **[Nife.io Quick Deploy documentation](https://docs.nife.io/overview/quick-deploy)**.

## Project Structure

| Path | Purpose |
| --- | --- |
| `src/` | Spring Boot application source code |
| `Dockerfile` | Container build instructions |
| `pom.xml` | Maven configuration and dependencies |
| `README.md` | Project documentation |
| `screenshots/` | Optional screenshots for documentation |

## License

This project is licensed under the **MIT License**. See the `LICENSE` file for details.

Copyright (c) 2026 Nife Labs

## Acknowledgements

This project is based on the original [`docker-spring-boot-java-web-service-example`](https://github.com/bzdgn/docker-spring-boot-java-web-service-example) repository by [@bzdgn](https://github.com/bzdgn).

This version is maintained by **Nifetency** and positioned as a sample deployment project for **[Nife.io](https://nife.io)**.
