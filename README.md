# Mabrains Packages

This repo builds docker containers for mabrains projects.

## Files
* the dockengspicer-publish.yml file when any push or pull_request run the bash file build_docker_image.sh
* build_docker_image.sh just build the Docker image  from Dockerfile
* Dockerfile based on ubuntu:22.04 image and copy the Makefile and run it
* Makefile install klayout, xyce and ngspice

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
