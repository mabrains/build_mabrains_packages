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

# =================================================================================================================
# ----------------------------------------------- Tools Installation ----------------------------------------------
# =================================================================================================================



klayout_version	    = "0.28"
klayout_link        = "https://github.com/KLayout/klayout.git"
xyce_version        = "Release-7.6.0"
xyce_link           = "https://github.com/Xyce/Xyce.git"
ngspice_version     = "38"
ngspice_link        = "https://downloads.sourceforge.net/project/ngspice/ng-spice-rework/$(ngspice_version)/ngspice-$(ngspice_version).tar.gz"
ENV_PATH           ?= "/tools_path"
all: tools_srcs  dep install_libraries install_klayout  build_ngspice_lib install_ngspice  install_xyce clean_builds
############################################
.ONESHELL:
install_libraries:
	pip3 install docopt pandas gdsfactory gdstk
	pip3 cache purge

######################################
tools_srcs:
	mkdir -p  tools_srcs


dep:
	apt-get update -qq \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y  install \
	build-essential gcc g++ make qtbase5-dev qttools5-dev autoconf libtool automake  gawk gfortran \
	bison flex libxaw7-dev  lib32readline8 lib32readline-dev libreadline8 libreadline-dev libblas-dev liblapack-dev libatlas-base-dev \
	libqt5xmlpatterns5-dev qtmultimedia5-dev libqt5multimediawidgets5 libqt5svg5-dev ruby ruby-dev python3 python3-dev libz-dev python3-pip git wget\
	&& apt-get autoclean && apt-get clean && apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/*


###############################################
.ONESHELL:
install_klayout: tools_srcs
	echo 'begin klayout installation';\
	cd tools_srcs ;\
	git clone $(klayout_link);\
	mkdir -p  $(ENV_PATH)/tools/klayout-$(klayout_version);\
	pwd;\
	pwd;\
	ls;\
	ls;\
        cd klayout ;\
	git checkout $(klayout_version);\
	./build.sh -j$$(nproc) ;\
	mv -f build-release/ bin-release/ $(ENV_PATH)/tools/klayout-$(klayout_version)/;\	
	echo 'export PATH=/tools/klayout-$KLAYOUT_VERSION:$PATH; export LD_LIBRARY_PATH=/tools/klayout-$KLAYOUT_VERSION:$LD_LIBRARY_PATH;' >> /root/.bashrc
	echo 'end klayout installation';\
	echo 'end klayout installation';\
	echo 'end klayout installation';\
	echo 'end klayout installation';\
	echo 'end klayout installation'
######################################################
ONESHELL:
download_ngspice: tools_srcs
	cd tools_srcs ;\
	wget -O ngspice-$(ngspice_version).tar.gz $(ngspice_link);\
	tar zxvf ngspice-$(ngspice_version).tar.gz
	
.ONESHELL:
build_ngspice_lib: download_ngspice 
	mkdir -p  $(ENV_PATH)/tools/ngspice-$(ngspice_version)/lib;\
	mkdir -p tools_srcs/ngspice-$(ngspice_version)/build-lib ;\
	cd tools_srcs/ngspice-$(ngspice_version)/;\
	./compile_linux.sh 64
	echo 'end build_ngspice_lib'
	echo 'end build_ngspice_lib'
	echo 'end build_ngspice_lib'
	echo 'end build_ngspice_lib'
	echo 'end build_ngspice_lib'

	
.ONESHELL:
install_ngspice: download_ngspice 
	echo 'begin install_ngspice'
	mkdir -p  $(ENV_PATH)/tools/ngspice-$(ngspice_version)/bin;\
	cd  tools_srcs/ngspice-$(ngspice_version)/release;\
	../configure prefix=$(ENV_PATH)/tools/ngspice-$(ngspice_version) --enable-cider --enable-xspice --enable-openmp --enable-pss --with-readline=yes --disable-debug --with-x	make -j$$(nproc);\
	make -j$$(nproc);\
	make install
	echo 'end install_ngspice'
	echo 'end install_ngspice'

############################################################
.ONESHELL:
download_xyce: tools_srcs 
	cd tools_srcs ;\
	git clone $(xyce_link)

.ONESHELL:
install_xyce: download_xyce
	mkdir -p  $(ENV_PATH)/tools/Xyce-$(xyce_version);\
	cd tools_srcs/Xyce ;\
	git checkout $(xyce_version);\
	./bootstrap;\
	mkdir build_dir;\
	cd build_dir;\
	echo 'begin config';\
	echo 'begin config';\
	echo 'begin config';\
	echo 'begin config';\
	echo 'begin config';\
	../configure 
	make -j$$(nproc);\
	make install

clean_builds:
	rm -rf tools_srcs
