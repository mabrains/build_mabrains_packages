klayout_version	    = "v0.28_dev"
klayout_link        ="https://github.com/KLayout/klayout.git"
xyce_version          = "Release-7.6.0"
xyce_link           ="https://github.com/Xyce/Xyce.git"
ngspice_version     = "38"
ngspice_link        ="https://downloads.sourceforge.net/project/ngspice/ng-spice-rework/$(ngspice_version)/ngspice-$(ngspice_version).tar.gz"

ENV_PATH         ?= "/tools_path"
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
	build-essential gcc g++ make qtbase5-dev qttools5-dev \
	libqt5xmlpatterns5-dev qtmultimedia5-dev libqt5multimediawidgets5 libqt5svg5-dev ruby ruby-dev python3 python3-dev libz-dev python3-pip git wget\
	&& apt-get autoclean && apt-get clean && apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/*

###############################################
.ONESHELL:
install_klayout: tools_srcs
	cd tools_srcs ;\
	git clone $(klayout_link);\
	cd klayout && ./build.sh -j$(nproc) && mkdir -p /tools/klayout-$KLAYOUT_VERSION && cp -rf bin-release/* /tools/klayout-$KLAYOUT_VERSION && cd .. && rm -rf klayout
	echo 'export PATH=/tools/klayout-$KLAYOUT_VERSION:$PATH; export LD_LIBRARY_PATH=/tools/klayout-$KLAYOUT_VERSION:$LD_LIBRARY_PATH;' >> /root/.bashrc
######################################################
.ONESHELL:
download_ngspice: tools_srcs
	cd tools_srcs ;\
	wget -O ngspice-$(ngspice_version).tar.gz $(ngspice_link);\
	tar zxvf ngspice-$(ngspice_version).tar.gz
	
.ONESHELL:
build_ngspice_lib: download_ngspice 
	mkdir -p  $(ENV_PATH)/tools/ngspice-$(ngspice_version)/lib;\
	mkdir -p tools_srcs/ngspice-$(ngspice_version)/build-lib ;\
	cd tools_srcs/ngspice-$(ngspice_version)/build-lib;\
	../configure prefix=$(ENV_PATH)/tools/ngspice-$(ngspice_version) --enable-cider --enable-xspice --enable-openmp --enable-pss --with-readline=yes --disable-debug --with-x --with-ngshared;\
	make -j$$(nproc);\
	make install;
.ONESHELL:
install_ngspice: download_ngspice 

	mkdir -p  $(ENV_PATH)/tools/ngspice-$(ngspice_version)/bin;\
	mkdir -p tools_srcs/ngspice-$(ngspice_version)/release ;\
	cd  tools_srcs/ngspice-$(ngspice_version)/release;\
	../configure prefix=$(ENV_PATH)/tools/ngspice-$(ngspice_version) --enable-cider --enable-xspice --enable-openmp --enable-pss --with-readline=yes --disable-debug --with-x
	make -j$$(nproc);\
	make install;

############################################################
.ONESHELL:
download_xyce: tools_srcs 
	cd tools_srcs ;\
	git clone $(xyce_link);

.ONESHELL:
install_xyce: download_xyce
	mkdir -p  $(ENV_PATH)/tools/Xyce-$(xyce_version);\
	cd tools_srcs/Xyce ;\
	git checkout $(xyce_version);\
	./bootstrap;\
	mkdir build_dir;\
	cd build_dir;\
	../configure CXXFLAGS="-O3" ARCHDIR="$(ENV_PATH)/tools/trilinos-$(trilinos_version)" CPPFLAGS="-I/usr/include/suitesparse" --enable-mpi CXX=mpicxx CC=mpicc F77=mpif77 --enable-stokhos --enable-amesos2 --enable-shared --enable-xyce-shareable --prefix=$(ENV_PATH)/tools/Xyce-$(xyce_version)
	make -j$$(nproc);\
	make install

clean_builds:
		rm -rf tools_srcs
