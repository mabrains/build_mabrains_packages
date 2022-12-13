#!/bin/bash -f
# Copyright 2022 Mabrains
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# 

export DEBIAN_FRONTEND=noninteractive

apt update  -y
apt upgrade -y
apt install -y vim htop build-essential git cmake autoconf automake flex bison texinfo libx11-dev libxaw7-dev libreadline-dev 
apt install -y tcl-dev tk-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev tcsh csh libcairo2-dev libncurses-dev libgsl-dev
apt install -y libgtk-3-dev clang gawk libffi-dev graphviz xdot pkg-config libboost-system-dev libboost-python-dev zlib1g-dev
apt install -y libboost-filesystem-dev gengetopt help2man groff pod2pdf libtool octave liboctave-dev epstool transfig paraview
apt install -y libhdf5-dev libvtk7-dev libboost-all-dev libcgal-dev libtinyxml-dev qtbase5-dev libvtk7-qt-dev libopenmpi-dev
apt install -y xterm graphicsmagick ghostscript libhdf5-serial-dev vtk7 cython3 python3 python3-pip pip python3-numpy gcc g++ 
apt install -y gfortran python3-matplotlib python3-scipy python3-h5py meld ffmpeg  make libfl-dev libfftw3-dev libsuitesparse-dev
apt install -y libblas-dev liblapack-dev uidmap apt-transport-https ca-certificates curl gnupg m4 wget autopoint gperf patchutils  
apt install -y perl libfl2 zlib1g ccache libgoogle-perftools-dev numactl perl-doc device-tree-compiler libexpat-dev
apt install -y clang-format-11 gtkwave autotools-dev libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev bc
apt install -y libcairo-dev swig libspdlog-dev npm ninja-build lemon libeigen3-dev libbz2-dev libboost-thread-dev
apt install -y libboost-program-options-dev liblzma-dev libboost-test-dev doxygen tclx8.4-dev neovim xvfb bzip2 gdb
apt install -y gettext libsm-dev libgomp1 libxml2-dev libxslt-dev ncurses-dev patch libpcre2-dev strace tcllib lsb-release
apt install -y guile-2.2 libpng-dev texlive-science texlive texlive-font-utils transfig gnuplot graphviz libxml2
apt install -y latex2html ps2eps python-tk texlive-extra-utils octave-communications-common texlive-publishers snapd
apt install -y libtool libtool-bin gperf flex bison pkg-config libxml-libxml-perl libgd-perl
apt install -y software-properties-common apt-transport-https qttools5-dev libqt5xmlpatterns5-dev qtmultimedia5-dev
apt install -y libqt5multimediawidgets5 libqt5svg5-dev ruby ruby-dev libz-dev environment-modules
apt install -y p7zip-full tree

apt autoremove
apt clean


