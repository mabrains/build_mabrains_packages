# Mabrains Packages

This repo builds docker containers for mabrains projects.

## Files
1. 
	* the docker-image-base.yml file when any **push on file base_image (only)** run the bash file build_docker_image.sh
	* build_docker_image.sh just build **the Base Docker image**  from Dockerfile
	* Dockerfile based on ubuntu:22.04 image and copy the install_libraries.sh and run it
2. 
	* the docker-image.yml file when any **push on file docker_image or docker-image-base.yml action completed** run the bash file build_docker_image.sh
	* build_docker_image.sh just build the Docker image  from Dockerfile
	* Dockerfile based on **the Base Docker image** and copy the Makefile and run it
## Running docker command
```bash
docker run -it -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT --env=DISPLAY --volume=/tmp/.X11-unix:/tmp/.X11-unix --net=host ghcr.io/mabrains/pdk_regression
 ```
## Running Locally 

* Run the BuildContainerImage
```bash
act -j BuildContainerImage
```
* Run the entire Pipeline:
 ```bash
 act
 ```

* View Execution Graph:
```bash
act -l
```
