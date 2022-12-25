# Mabrains Packages

This repo builds docker containers for mabrains projects.

## Files
* the dockengspicer-publish.yml file when any push or pull_request run the bash file build_docker_image.sh
* build_docker_image.sh just build the Docker image  from Dockerfile
* Dockerfile based on ubuntu:22.04 image and copy the Makefile and run it
* Makefile install klayout, xyce and ngspice
## Running docker command

## Running Locally 
```bash
docker run -it -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT --env=DISPLAY --volume=/tmp/.X11-unix:/tmp/.X11-unix --net=host ghcr.io/mohamed-gomaa1/pdk_regression
 ```
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
