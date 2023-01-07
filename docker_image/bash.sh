#!/bin/bash
echo 'export PATH="/tool_path/tools/klayout-v0.28/bin-release:$PATH"' >> /root/.bashrc
echo 'export LD_LIBRARY_PATH="/tool_path/tools/klayout-v0.28/bin-release:$LD_LIBRARY_PATH"' >> /root/.bashrc 
echo 'export PATH="/tool_path/tools/ngspice-38/bin:$PATH"' >> /root/.bashrc
echo 'export PATH="/tool_path/tools/Xyce-Release-7.6.0/bin:$PATH"' >> /root/.bashrc
source /root/.bashrc
