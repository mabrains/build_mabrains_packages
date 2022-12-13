
# Copyright 2022 Mabrains
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# syntax = docker/dockerfile:1.0-experimental
FROM ubuntu:22.04 as build
COPY ./Makefile /Makefile
COPY ./cmake_init.sh /cmake_init.sh
COPY ./install_libraries.sh  /install_libraries.sh
RUN cd / && DEBIAN_FRONTEND="noninteractive" apt-get update
RUN apt-get install make
RUN cd / && chmod +x install_libraries.sh && DEBIAN_FRONTEND="noninteractive" ./install_libraries.sh
RUN cd / && DEBIAN_FRONTEND="noninteractive" make all
RUN cd / && DEBIAN_FRONTEND="noninteractive" make clean_builds
RUN cd / && DEBIAN_FRONTEND="noninteractive" rm install_libraries.sh cmake_init.sh Makefile
