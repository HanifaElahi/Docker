# Docker


# Docker Hello World  


```bash
docker run hello-world
```


- This pulls the latest hello-world image and runs it.
- If we run this again, it doesn't download the image again because it's already cached.

If want to pull a specific image without running it:


```bash
docker pull hello-world
```


# Containers vs. Images  

### Images  
- **Templates for containers**:  
  - Specify file systems, users, environment variables, default commands, and more.  
- These are what you **download** or **share**.  

### Containers  
- **Groups of processes**:  
  - Based on an image.  
  - You can have multiple containers created from the same image.  
- Containers run the application in an isolated environment.  

# Port Mapping  

### Pulling and Running NGINX  

- NGINX is available on Docker Hub, which is the public image registry Docker uses if no registry is specified.  
- To run an NGINX container:  


```bash
docker run nginx
```


- Containers are isolated from the host's network by default.
- To interact with the NGINX server from your host, you need to publish the port the container is listening on.

### Publishing Ports

Ports can be published using the -p flag:

- Default Port (80): Map port 80 of the container to port 80 of your host


```bash
docker run -p 80:80 nginx
```


- Custom Host Port: Map port 80 of the container to port 8000 of your host


```bash
docker run -p 8000:80 nginx
```


# Running a Docker Container in the Background  

### Foreground vs. Background Execution  
By default, Docker runs containers in the foreground.  

To run a container in the background (detached mode), use the `-d` flag:  


```bash
docker run -p 8000:80 -d nginx
```


- This will start the container in detached mode and return the container ID.
- You can refer to the container using its ID or name.

### Viewing Logs

To view the logs of a running container:


```bash
docker logs <container-name-or-id>
```


### Stopping a Container

To stop a running container:


```bash
docker stop <container-name-or-id>
```


### Removing Stopped Containers

To remove all stopped containers:


```bash
docker container prune
```


### Automatic Cleanup

To automatically remove a container when it stops, use the --rm flag:


```bash
docker run -p 8000:80 -d --rm nginx
```


# Docker Image Tagging  

### Default Behavior  
When running an image without specifying a tag, Docker uses the `latest` tag by default:  


```bash
docker run nginx
```


- This will pull the latest version of the image or use the latest downloaded version if it's already available.

### Specifying a Tag

To run a specific version of an image, include the tag:


```bash
docker run nginx:1.27
```


- Here, 1.27 is the specified tag.


Tags are mutable:

- For example, nginx:1.27 might initially refer to 1.27.0.
- When 1.27.1 is released, the tag 1.27 will point to this newer version.
- Essentially, tags like 1.27 always point to the latest image in that category.


### Digests for Immutable References

A digest is an immutable identifier tied to a specific image version at the time of pulling.

To view digests of images, use:


```bash
docker image ls --digests
```


#### Best Practices for Production

- In production, it is highly recommended to use digests instead of tags.
- Digests ensure you're always using the exact same image version, preventing unexpected changes due to mutable tags.


# Runtime: Running with Environment Variables and Arguments  

### Passing Environment Variables  
You can pass environment variables to a container using the `-e` flag:  


```bash
docker run -e ABC=123 -e DEF=456 python:3.12 python -c "import os; print(os.environ)"
```


- The -e flag sets environment variables (ABC=123, DEF=456).
- The -c flag allows you to run an inline script.
- This command pulls the python:3.12 image, which is approximately 1.01GB in size.

### Slim and Alpine Images

In production, image size matters a lot for performance and storage efficiency.

#### Slim Images

To pull the slim version of an image:


```bash
docker pull python:3.12-slim
```

**The slim version is nearly 10 times smaller than the non-slim version.**

#### Alpine Images

To pull the Alpine version of an image:


```bash
docker pull python:3.12-alpine
```


**The Alpine version is around half the size of the slim version and 20 times smaller than the non-slim version.**


#### Alpine vs. Slim Images


| Feature               | **Slim Images**                               | **Alpine Images**                                |
|-----------------------|-----------------------------------------------|--------------------------------------------------|
| **Base Linux**         | Typically **Debian-based**                    | **Alpine Linux**                                 |
| **Size**               | **10x smaller** than the non-slim version     | **20x smaller** than the non-slim version        |
| **Default Shell**      | **Bash**                                      | **Ash**                                          |
| **C Library**          | **glibc**                                     | **musl libc**                                    |
| **Package Manager**    | **apt** (Debian-based)                       | **apk**                                          |
| **Typical Use Case**   | General use when size is a concern but still requires a full Debian-based environment | Best for very minimal setups and smaller container images |
| **Compatibility**      | Works with many libraries and tools designed for **glibc** | May require adjustments for compatibility with **glibc**-dependent applications |


# Debugging Containers

### Viewing Logs
To run a container in the background (detached mode) and view its logs:


```bash
docker run -d nginx
```


Then, you can check the logs of a running container using its container ID:

```bash
docker logs <container-id>
```

### Running a Command Inside a Running Container

To run a command or process inside an already running container, you can use docker exec:


```bash
docker exec -it <container-id> /bin/bash
```


- The -it flag stands for interactive, allowing you to run commands in the container's shell.
- In this example, we’re accessing the container’s shell (/bin/bash), and you can use commands like whoami to check the current user inside the container.


# Persistence in Docker  

By default, every time we run a Docker container, it starts fresh with the same file system. Any changes made during previous runs are lost.  

### Example: No Persistence  
The following command writes to a file inside the container, but the data is lost when the container is stopped:  


```bash
docker run python:3.12 python -c 'f="/data.txt";open(f, "a").write(f"Ran!\n");print(open(f).read())'
```


- Every time you run this, you'll only see one copy of "Ran!\n".

### Achieving Persistence with Mounts

To retain data between container runs, we can use mounts. Here's an example using a volume:


```bash
docker run -v mydata:/data python:3.12 python -c 'f="/data/data.txt";open(f, "a").write(f"Ran!\n");print(open(f).read())'
```


# Persistence

Every time we run a docker contwiner, we start fresh with the same file system everytime, previosu all runs are gone


```bash
docker run python:3.12 python -c 'f="/data.txt";open(f, "a").write(f"Ran!\n");print(open(f).read())'
```

- This command uses the -v flag to mount a volume (mydata) to /data in the container.
- Now, the data persists between container runs.


#### Types of Mounts in Docker


| Type                | Persistence | Description                                      |
|---------------------|-------------|--------------------------------------------------|
| **Volumes**         | Yes         | Managed by the Docker daemon. Recommended for most cases. |
| **Bind-Mounts**     | Yes         | Mounts a host file or directory into the container. Useful for direct host-container interaction. |
| **Tmpfs Mounts**    | No          | Stores data in memory only. Data is lost when the container stops. |


#### Volumes vs. Bind-Mounts


| Feature                  | **Volumes**                           | **Bind-Mounts**                          |
|--------------------------|---------------------------------------|------------------------------------------|
| **Age**                  | Newer                                 | Older (but still useful)                 |
| **Features**             | More features                        | Fewer features                           |
| **Management**           | Managed by Docker daemon             | Mounts host files/directories directly   |




##### Sources : 

- [Docker Tutorial for Beginners](https://www.youtube.com/watch?v=b0HMimUb4f0) by [mCoding](https://www.youtube.com/@mCoding)
- [Free Docker Fundamentals Course - just enough docker to do stuff](https://www.youtube.com/playlist?list=PLTk5ZYSbd9Mg51szw21_75Hs1xUpGObDm) by [LearnCantrill](https://www.youtube.com/@LearnCantrill)
