# build_mabrains_packages
All Mabrains Docker Images Build Process
## the flow
* the docker-publish.yml file run build_docker_image.sh whitch build the Dockerfile 
* then Docker file copy and run Makefile
### the bulit image uploaded to github [link]
## to run act 

   * act -j BuildContainerImage - run the BuildContainerImage
   * act - run the the entire pipeline
   * act -l - view the execution graph


[link]: https://hub.docker.com/repository/docker/mohamedgomaa12/my_repo
