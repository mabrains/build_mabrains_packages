##/bin/bash -f

docker build -t "$IMAGE" - <<EOF
FROM ubuntu:22.04

RUN apt-get update -qq \
&& DEBIAN_FRONTEND=noninteractive apt-get -y  install \
    build-essential gcc g++ make qtbase5-dev qttools5-dev \
    libqt5xmlpatterns5-dev qtmultimedia5-dev libqt5multimediawidgets5\
    libqt5svg5-dev ruby ruby-dev python3 python3-dev libz-dev python3-pip git\
&& apt-get autoclean && apt-get clean && apt-get -y autoremove \
&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/KLayout/klayout.git
RUN cd klayout && git checkout $KLAYOUT_VERSION && ./build.sh -j$(nproc) && mkdir -p /tools/klayout-$KLAYOUT_VERSION && cp -rf bin-release/* /tools/klayout-$KLAYOUT_VERSION
EOF