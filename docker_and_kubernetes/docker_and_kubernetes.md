# Docker & Kubernetes

- [Docker \& Kubernetes](#docker--kubernetes)
- [Teachable Notes](#teachable-notes)
  - [Microservices](#microservices)
- [Docker](#docker)
  - [Docker Compose](#docker-compose)
- [Kubernetes](#kubernetes)
- [Task](#task)

# Teachable Notes
From the Teachable course, please prepare yourself to answer questions similar to these:

- Differences between virtualisation and containerisation
    VMs are fully simulated machines complete with OS and such. Containers are smaller units packaged with only the specific dependencies for that application.
- What is usually included in a container vs virtual machine?
- Pros/cons of using:
  - Traditional architecture.
        Simple, easy, but no flexibility. Hard to scale up or down.
  - Virtualisation.
        Let's you run multiple systems on one machine, so more flexible than ^^. But each VM has to simulate an entire OS, so they're pretty resource heavy.
  - Containerisation.
        Lighter weight than VMs. Smaller and cross-platform, making them more flexible again. Doesn't have to copy the whole OS.
  - Docker.
        See below
- What is it?
    Container creating/management/distribution tool
- Why Docker?
    Open source, community support, multi-cloud
- How do you get Docker going?
- What are some basic Docker commands?
- What is DockerHub? 
      Official docker container registry. by default, public
  - How does it relate to Docker?
- Why are ports important to consider when running containers?
- Why create a Docker image?
- How can you automate image creation?

## Microservices
Wee diddy individual parts of the whole application, split into chunks. Allows scaling of specific subsytems. Reduces coupling. Subsystems can be workon/updated seperately

# Docker
- `docker exec -it [container] [command]`

## Docker Compose
- for multi-container Docker applications
- defined in a YAML file
- use Docker Compose to start/stop/manages services defined in YAML file (docker-compose.yaml)
- `docker-compose up` runs the composer. 
  - `-d` runs detatched mode, so it won't show any logs or freeze your terminal.
  - `docker-compose ps` shows composed containers.
  - basically, most docker commaands work with docker-compose.

# Kubernetes
Can be used as an orchestration tool


# Task

Aim: Run Sparta test NodeJS app in a Docker container, and push your image to DockerHub
Duration: Allow 1 hour, then finish documentation
Steps:

Create a new folder (because you can only have one Dockerfile per folder)
Put your 'app' folder in the that folder
Create a new Dockerfile (see below for the Dockerfile starting code)
Similar commands to these will be needed later, especially to show the app running in the brower at port 3000:
docker build -t daraymonsta/tech201-app:v1 .
docker run -d -p 3000:3000 daraymonsta/tech201-app:v1
docker push daraymonsta/tech201-app:v1
