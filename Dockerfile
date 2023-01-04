FROM robotastic/trunk-recorder:latest

# Build MQTT Stats
RUN apt update && export DEBIAN_FRONTEND=noninteractive && \ 
    apt install -y doxygen && rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    git clone https://github.com/eclipse/paho.mqtt.c.git && \
    cd paho.mqtt.c && \
    cmake -Bbuild -H. -DPAHO_ENABLE_TESTING=OFF -DPAHO_BUILD_STATIC=ON  -DPAHO_WITH_SSL=ON -DPAHO_HIGH_PERFORMANCE=ON && \
    cmake --build build/ --target install && \
    ldconfig && \
    cd /tmp && \
    git clone https://github.com/eclipse/paho.mqtt.cpp && \
    cd paho.mqtt.cpp && \
    cmake -Bbuild -H. -DPAHO_BUILD_STATIC=ON  -DPAHO_BUILD_DOCUMENTATION=TRUE -DPAHO_BUILD_SAMPLES=TRUE && \
    cmake --build build/ --target install && \
    ldconfig && \
    cd /tmp && \
    git clone https://github.com/robotastic/trunk-recorder-mqtt-status.git && \
    cd trunk-recorder-mqtt-status && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make install
