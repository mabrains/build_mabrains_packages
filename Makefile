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

CC=g++
SHELL:=/bin/bash

# ==== Tools path ====
ENV_PATH         ?= "/tool_path"





# ==== Checks & Layout tools links ====

klayout_link          ="https://github.com/KLayout/klayout.git"

# ==== Analog tools links ====
ngspice_version       = "38"
trilinos_version      = "12-12-1"
xyce_version          = "Public_Release-7.6.0"

ngspice_link          ="https://downloads.sourceforge.net/project/ngspice/ng-spice-rework/$(ngspice_version)/ngspice-$(ngspice_version).tar.gz"
trilinos_link         ="https://github.com/trilinos/Trilinos/archive/refs/tags/trilinos-release-$(trilinos_version).tar.gz"
xyce_link             ="https://github.com/Xyce/Xyce.git"


# ==== MAKE TARGETS =====
all               : tools_srcs  build_utils install_klayout install_ngspice_lib build_ngspice  build_xyce    clean_builds env_info


# =========================================================================================== 
# ------------------------------- Dependiencies installation --------------------------------
# ===========================================================================================


.ONESHELL:
build_utils:
	@mkdir -p $(ENV_PATH)/tools/pythonlibs-${pythonlibs_version}
	@/usr/bin/pip3 install pandas docopt Jinja2
	@/usr/bin/pip3 install --target=$(ENV_PATH)/tools/pythonlibs-${pythonlibs_version} -U pandas klayout gdsfactory docopt Jinja2 click pyyaml

	
.ONESHELL:
env_info:
	@echo "Make sure the following two lines are set (or add them to ~/.bashrc)\n"

tools_srcs:
	@mkdir -p  tools_srcs


pdks_dir:
	@mkdir -p  $(PDK_ROOT)



# =========================================================================================== 
# --------------------------- Checks and Layout Tools Installation --------------------------
# ===========================================================================================

.ONESHELL:
download_klayout:
	@cd tools_srcs/
	@sh -c "if [ -d klayout ]; then \
				echo 'klayout src is already exist';\
			else \
				git clone $(klayout_link); \
            fi"

.ONESHELL:
install_klayout: tools_srcs env_dir download_klayout
	@sh -c "if [ -d $(ENV_PATH)/tools/klayout-$(klayout_version) ]; then \
				echo 'klayout is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/klayout-$(klayout_version);\
                		cd tools_srcs/klayout ;\
				git checkout $(klayout_version);\
				./build.sh -j$$(nproc) ;\
				mv -f build-release/ bin-release/ $(ENV_PATH)/tools/klayout-$(klayout_version)/;\
				echo 'export PATH=/tools/klayout-$KLAYOUT_VERSION:$PATH; export LD_LIBRARY_PATH=/tools/klayout-$KLAYOUT_VERSION:$LD_LIBRARY_PATH;' >> /root/.bashrc;\
            fi"


# =========================================================================================== 
# -------------------------------- Analog Tools Installation --------------------------------
# ===========================================================================================
.ONESHELL:
download_ngspice: tools_srcs env_dir
	@cd tools_srcs/
	@sh -c "if [ -d ngspice-$(ngspice_version) ]; then \
				echo 'ngspice src is already exist';\
			else \
				wget -O ngspice-$(ngspice_version).tar.gz $(ngspice_link);\
				tar zxvf ngspice-$(ngspice_version).tar.gz;\
            fi"

.ONESHELL:
install_ngspice: download_ngspice 
	@sh -c "if [ -d $(ENV_PATH)/tools/ngspice-$(ngspice_version)/lib ]; then \
				echo 'ngspice lib is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/ngspice-$(ngspice_version)/lib;\
                mkdir -p tools_srcs/ngspice-$(ngspice_version)/build-lib ;\
				cd tools_srcs/ngspice-$(ngspice_version)/build-lib;\
				../configure prefix=$(ENV_PATH)/tools/ngspice-$(ngspice_version) --enable-cider --enable-xspice --enable-openmp --enable-pss --with-readline=yes --disable-debug --with-x --with-ngshared;\
				make -j$$(nproc);\
				make install;\
				
			fi"

	@sh -c "if [ -d $(ENV_PATH)/tools/ngspice-$(ngspice_version)/bin ]; then \
				echo 'ngspice is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/ngspice-$(ngspice_version)/bin;\
                mkdir -p tools_srcs/ngspice-$(ngspice_version)/release ;\
				cd  tools_srcs/ngspice-$(ngspice_version)/release;\
				../configure prefix=$(ENV_PATH)/tools/ngspice-$(ngspice_version) --enable-cider --enable-xspice --enable-openmp --enable-pss --with-readline=yes --disable-debug --with-x
				make -j$$(nproc);\
				make install;\
				echo 'export PATH=/tools/ngspice-$(ngspice_version):$PATH;' >> /root/.bashrc;\

			fi"

.ONESHELL:
build_ngspice: install_ngspice  


.ONESHELL:
download_trilinos: tools_srcs env_dir
	@cd tools_srcs/
	@sh -c "if [ -d Trilinos-trilinos-release-$(trilinos_version) ]; then \
				echo 'Trilinos src is already exist';\
			else \
				wget $(trilinos_link);\
				tar zxvf trilinos-release-$(trilinos_version).tar.gz;\
            fi"

.ONESHELL:
install_trilinos: download_trilinos
	@sh -c "if [ -d $(ENV_PATH)/tools/trilinos-$(trilinos_version) ]; then \
				echo 'Trilinos is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/trilinos-$(trilinos_version);\
                mkdir -p tools_srcs/Trilinos-trilinos-release-$(trilinos_version)/parallel_build ;\
				cp cmake_init.sh tools_srcs/Trilinos-trilinos-release-$(trilinos_version)/parallel_build;\
				cd tools_srcs/Trilinos-trilinos-release-$(trilinos_version)/parallel_build;\
				chmod +x cmake_init.sh;\
				./cmake_init.sh  $(ENV_PATH)/tools/trilinos-$(trilinos_version);\
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
build_trilinos: install_trilinos
	pwd
	
.ONESHELL:
download_xyce: tools_srcs env_dir
	@cd tools_srcs/
	@sh -c "if [ -d Xyce ]; then \
				echo 'Xyce src is already exist';\
			else \
				git clone $(xyce_link);\
            fi"

.ONESHELL:
install_xyce: download_xyce
	@sh -c "if [ -d $(ENV_PATH)/tools/Xyce-$(xyce_version) ]; then \
				echo 'Xyce is already installed';\
			else \
				mkdir -p  $(ENV_PATH)/tools/Xyce-$(xyce_version);\
                cd tools_srcs/Xyce ;\
				git checkout $(xyce_version);\
				./bootstrap;\
				mkdir build_dir;\
				cd build_dir;\
				../configure CXXFLAGS="-O3" ARCHDIR="$(ENV_PATH)/tools/trilinos-$(trilinos_version)" CPPFLAGS="-I/usr/include/suitesparse" --enable-mpi CXX=mpicxx CC=mpicc F77=mpif77 --enable-stokhos --enable-amesos2 --enable-shared --enable-xyce-shareable --prefix=$(ENV_PATH)/tools/Xyce-$(xyce_version)
				make -j$$(nproc);\
				make install;\
            fi"

.ONESHELL:
build_xyce: build_trilinos install_xyce
	@echo "xyce finished" 


# =========================================================================================== 
# ---------------------------------------- CLEAN SRCS ---------------------------------------
# ===========================================================================================

clean_builds:
	rm -rf tools_srcs

# =========================================================================================== 
# ------------------------------------------- HELP ------------------------------------------
# ===========================================================================================

help:
	@echo "============= The following are some of the valid targets for this Makefile ============="
	@echo "... all                        (the default if no target is provided                         )"
	@echo "... clean                      (To clean tools installation data                             )"
	@echo "... all_analog                 (To build analog  open source tools like xyce, ngspice, ..  )"
  
	@echo "\n ======== The following are some of the valid targets for analog tools installation ========"  
	@echo "... build_ngspice              (To build ngspice simulator and its libraries                 )"
	@echo "... build_xyce                 (To build Xyce simulator and its libraries                    )"
