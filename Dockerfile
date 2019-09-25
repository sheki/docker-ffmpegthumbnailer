FROM lsiobase/ubuntu:xenial
RUN apt-get update
RUN apt-get install -y pkg-config \
 g++ \
 cmake \
 libavcodec-dev \
 libavformat-dev \
 libavutil-dev \
 libavfilter-ffmpeg5 \
 libavfilter-dev \
 libavutil-ffmpeg54 \
 libavformat-ffmpeg56 \
 libavcodec-ffmpeg-extra56 \
 libjpeg8 \
 libjpeg8-dev \
 libpng12-dev
RUN mkdir -p /opt
ADD ffmpegthumbnailer-2.2.0.tar.gz /opt/
WORKDIR /opt/ffmpegthumbnailer-2.2.0
ENV LD_LIBRARY_PATH /usr/local/lib:/usr/local/lib64
RUN cmake -DCMAKE_BUILD_TYPE=Release \
 -DENABLE_GIO=ON \
 -DENABLE_THUMBNAILER=ON \
 -dENABLE_SHARED=off \
 -DENABLE_STATIC=on .
RUN make clean
RUN make
RUN make install
WORKDIR /
RUN ffmpegthumbnailer -version
