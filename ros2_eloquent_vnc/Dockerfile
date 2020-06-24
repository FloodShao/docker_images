## ROS2 eloquent desktop environment setup

# Base system ubuntu-bionic-vnc-base

FROM floodshao/ubuntu-bionic-vnc-base
ENV REFRESHED_AT 2020-06-23

# The original USER is configured as 1000:0, without authentic for package install
# switch to root user
USER 0

## ROS2 eloquent install

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    apt-get update && apt-get install -q -y tzdata && rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources list
RUN echo "deb http://packages.ros.org/ros2/ubuntu bionic main" > /etc/apt/sources.list.d/ros2-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO eloquent
# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# setup colcon mixin and metadata
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update

# install python packages
RUN pip3 install -U \
    argcomplete

# install ros2 packages
RUN apt update && apt install -y \
    ros-$ROS_DISTRO-desktop \
    && rm -rf /var/lib/apt/lists/*

# source environment
RUN bash -c 'echo "source /opt/ros/$ROS_DISTRO/setup.bash" > /headless/.bashrc'
RUN bash -c 'source /headless/.bashrc'

## install gazebo

# install gazebo9
# for installation of gazebo9
## setup sources list
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
## setup keys
RUN bash -c 'wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -'
## install gazebo9 (latest version)
RUN apt-get update && apt-get install -y \
  gazebo9 \
  libgazebo9-dev \
  ros-$ROS_DISTRO-gazebo-ros-pkgs \
  ros-$ROS_DISTRO-gazebo-ros \
  ros-$ROS_DISTRO-gazebo-msgs \
  ros-$ROS_DISTRO-gazebo-dev \
  && rm -rf /var/lib/apt/lists/*

# dependencies for source install ignition
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
RUN apt-get update

RUN apt update && apt install -y g++-8
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8


# install ros2 argments autoocmplete
RUN apt install -y \
    python3-argcomplete \
    && rm -rf /var/lib/apt/lists/*

## rmf demos environment
# install mercurial pakage to use hg
RUN apt-get update && apt-get install -y \
    mercurial \
    && rm -rf /var/lib/apt/lists/*

# dependencies
RUN apt update && sudo apt install -y \
  cmake \
  wget \
  python3-vcstool \
  qt5-default \
  libeigen3-dev \
  libwebsocketpp-dev \
  libboost-all-dev \
  curl \
  python3-shapely \
  python3-yaml \
  python3-requests \
  && rm -rf /var/lib/apt/lists/*

# rosdep dependencies
RUN apt-get update && apt-get install -y \
  libccd-dev \
  libfcl-dev \
  ros-$ROS_DISTRO-launch-xml \
  libyaml-cpp-dev \
  python-shapely \
  && rm -rf /var/lib/apt/lists/*

# install thirdpart_lib dependencies
## for Menge
RUN apt-get update && apt-get install -y \
  libsdl2-ttf-dev \
  libsdl2-image-dev \
  libsdl2-dev \
  && rm -rf /var/lib/apt/lists/*

# install gdb
RUN apt-get update && apt-get install -y gdb \
  && rm -rf /var/lib/apt/lists/*

# source install ignition dependencies
RUN apt-get update && apt-get install -y \
  freeglut3-dev \
  libavcodec-dev \
  libavdevice-dev \
  libavformat-dev \
  libavutil-dev \
  libdart6-collision-ode-dev \
  libdart6-dev \
  libdart6-utils-urdf-dev \
  libfreeimage-dev \
  libgflags-dev \
  libglew-dev \
  libgts-dev \
  libogre-1.9-dev \
  libogre-2.1-dev \
  libprotobuf-dev \
  libprotobuf-dev \
  libprotoc-dev \
  libqt5core5a \
  libswscale-dev \
  libtinyxml2-dev \
  libtinyxml-dev \
  pkg-config \
  protobuf-compiler \
  python \
  qml-module-qt-labs-folderlistmodel \
  qml-module-qt-labs-settings \
  qml-module-qtquick2 \
  qml-module-qtquick-controls \
  qml-module-qtquick-controls2 \
  qml-module-qtquick-dialogs \
  qml-module-qtquick-layouts \
  qml-module-qtqml-models2 \
  qtbase5-dev \
  qtdeclarative5-dev \
  qtquickcontrols2-5-dev \
  ruby \
  ruby-ronn \
  uuid-dev \
  libzip-dev \
  libjsoncpp-dev \
  libcurl4-openssl-dev \
  libyaml-dev \
  libzmq3-dev \
  libsqlite3-dev \
  libwebsockets-dev \
  swig \
  ruby-dev \
  && rm -rf /var/lib/apt/lists/*


# switch back to 1000:0
USER 1000

CMD ["bash"]
