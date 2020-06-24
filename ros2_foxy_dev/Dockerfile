## ROS2 foxy desktop environment setup, from source

# Base system ubuntu-focal-vnc-base
FROM floodshao/ubuntu-focal-vnc-base
ENV REFRESHED_AT 2020-06-23

# The original USER is configured as 1000:0, without authentic for package install
# switch to root user
USER 0

## ROS2 foxy installation dependencies

# Set locale
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

# add ROS2 apt repository
RUN apt update && apt install -y \
	curl \
	gnupg2 \
	lsb-release \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# add the repository to your sources list
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# install development tools and ROS tools
RUN apt update && apt install -y \
  build-essential \
  cmake \
  git \
  libbullet-dev \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-pip \
  python3-pytest-cov \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget

# install some pip packages needed for testing
RUN python3 -m pip install -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest

# install Fast-RTPS dependencies
RUN apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev
# install Cyclone DDS dependencies
RUN apt install --no-install-recommends -y \
  libcunit1-dev \
  && rm -rf /var/lib/apt/lists/*

# binary install ros2 foxy
ENV ROS_DISTRO foxy
# RUN apt update && apt install -y ros-$ROS_DISTRO-desktop
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO


# dependencies for source install ignition
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -
RUN apt-get update

#RUN apt update && apt install -y g++-8
#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8


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
  && rm -rf /var/lib/apt/lists/*

# install gdb
RUN apt-get update && apt-get install -y gdb \
  && rm -rf /var/lib/apt/lists/*

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
RUN apt update && apt install -y \
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
  python3-shapely \
  && rm -rf /var/lib/apt/lists/*

# switch back to 1000:0
USER 1000

CMD ["bash"]



