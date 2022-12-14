# build_mabrains_packages
All Mabrains Docker Images Build Process
## the flow
* the dockengspicer-publish.yml file when any push or pull_request run the bash file build_docker_image.sh
* build_docker_image.sh just build the Docker image  from Dockerfile
* Dockerfile based on ubuntu:22.04 image and copy the Makefile and run it
* Makefile install klayout, xyce and ngspice
### the bulit image uploaded to github [link]
## to run act 

   * act -j BuildContainerImage - run the BuildContainerImage
   * act - run the the entire pipeline
   * act -l - view the execution graph


[link]: https://hub.docker.com/repository/docker/mohamedgomaa12/my_repo
