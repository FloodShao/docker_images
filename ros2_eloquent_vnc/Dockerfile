## ROS2 eloquent desktop environment setup

# Base system ubuntu-bionic-vnc-base

FROM floodshao/ubuntu-bionic-vnc-base
ENV REFRESHED_AT 2018-03-18

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
    ros-eloquent-desktop \
    && rm -rf /var/lib/apt/lists/*

# source environment
RUN bash -c 'echo "source /opt/ros/$ROS_DISTRO/setup.bash" > /headless/.bashrc'
RUN bash -c 'source /headless/.bashrc'

## install gazebo

# setup sources list
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'

# setup keys
RUN bash -c 'wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -'

# install gazebo
RUN apt-get update && apt-get install -y \
	gazebo11


# switch back to 1000:0
USER 1000

CMD ["bash"]