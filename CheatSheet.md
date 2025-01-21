# Docker Commands Cheat Sheet

## Docker Basics

### What is Docker?
Docker is a platform for developing, shipping, and running applications inside isolated containers. Containers solve issues related to dependencies, configurations, and environment differences.

---

## Docker Image Commands

### Build a Docker Image

```bash
docker build .
```

**Note:** The `.` specifies the current directory as the build context.

### Build a Docker Image with a Tag

```bash
docker build -t hello-docker .
```

**Note:** The `-t` flag assigns a tag (name) to the image, and `.` specifies the current directory.

### List Docker Images

```bash
docker images
```

### Pull a Docker Image

```bash
docker pull <image-name>
```

Example:

```bash
docker pull nginx
```

### View Image Digests

```bash
docker image ls --digests
```

---

## Docker Container Commands

### Create and Run a Container from an Image

```bash
docker run -d -p 80:80 <image-id>
```

Example:

```bash
docker run -d -p 80:80 nginx
```

**Notes:**
- `-d`: Runs the container in detached mode (background).
- `-p 80:80`: Maps port 80 of the host to port 80 of the container.

### Run a Container with Environment Variables

```bash
docker run -e ENV_VAR_NAME=value <image-name>
```

Example:

```bash
docker run -e ABC=123 python:3.12 python -c "import os; print(os.environ)"
```

### View Running Containers

```bash
docker ps
```

### View All Containers (Including Stopped Ones)

```bash
docker ps -a
```

### View Logs of a Container

```bash
docker logs <container-id>
```

### Run a Command Inside a Running Container

```bash
docker exec -it <container-id> /bin/bash
```

**Note:** The `-it` flag allows interactive access to the container's shell.

### Stop a Running Container

```bash
docker stop <container-id>
```

### Restart a Stopped Container

```bash
docker start <container-id>
```

### Remove Stopped Containers

```bash
docker container prune
```

### Automatically Remove a Container After It Stops

```bash
docker run --rm <image-name>
```

---

## Port Mapping

### Default Port Mapping

```bash
docker run -p 80:80 nginx
```

### Custom Host Port Mapping

```bash
docker run -p 8000:80 nginx
```

---

## Persistent Data

### Run Without Persistence

```bash
docker run python:3.12 python -c 'f="/data.txt";open(f, "a").write("Ran!\n");print(open(f).read())'
```

### Run with Persistent Data (Using Volumes)

```bash
docker run -v mydata:/data python:3.12 python -c 'f="/data/data.txt";open(f, "a").write("Ran!\n");print(open(f).read())'
```

**Notes:**
- `-v mydata:/data`: Mounts a volume named `mydata` to `/data` in the container.
- Changes persist between container runs.

---

## Managing Docker Images

### Specify a Tag When Pulling or Running an Image

```bash
docker pull python:3.12-slim
```

### Use Alpine Images for Smaller Size

```bash
docker pull python:3.12-alpine
```

**Comparison:**
- **Slim Images**: Smaller than default images; uses Debian-based environment.
- **Alpine Images**: Minimalist, uses Alpine Linux; even smaller than slim.

---

## Debugging Containers

### View Logs of a Running Container

```bash
docker logs <container-id>
```

### Access a Container's Shell

```bash
docker exec -it <container-id> /bin/bash
```

### Check Active Users in the Container

```bash
whoami
```

---

## Best Practices

### Use Immutable Digests for Production

```bash
docker pull <image-name>@<digest>
```

### Clean Up Stopped Containers

```bash
docker container prune
```

---

## Hello World Example

### Run a Hello World Container

```bash
docker run hello-world
```

**Note:** The first run downloads the image; subsequent runs use the cached version.

### Pull a Hello World Image Without Running

```bash
docker pull hello-world
```

