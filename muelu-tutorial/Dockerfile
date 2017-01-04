# build docker container using
#   docker build --build-arg username=tutorial -t tawiesn/muelu-tutorial .
# run the container using
#   docker run -i -t tawiesn/muelu-tutorial /bin/bash
#   docker run -dP -p 5901:5901 tawiesn/muelu-tutorial
# This image contains a basic CentOS with a standard development environment
# (compilers, MPI, ...)
#
FROM tawiesn/dev-tpl
ARG username=tutorial

#########################

# Install LXDE, VNC server
RUN yum -y update && \
    yum -y install htop xterm nano openbox tightvnc-server \
	doxygen gnuplot gedit xfce4-terminal && \
    yum clean all;

#########################    
    
#RUN yum update; \
#    yum -y install doxygen; \
#    yum -y install gnuplot; \
#    yum -y install gedit; \
#    yum -y install xfce4-terminal; \
#    yum clean all;

# create user (but run the commands as root)
#RUN adduser $username
#WORKDIR /home/$username

# copy files to image
#COPY download_trilinos.sh /opt/trilinos/
COPY install_trilinos.sh /opt/trilinos/
COPY do-configure /opt/trilinos/

# copy or download trilinos source files

RUN wget -nv https://trilinos.org/oldsite/download/files/trilinos-12.8.1-Source.tar.gz -O /opt/trilinos/trilinos.tar.gz

#WORKDIR /home/$username
#RUN chmod 750 /opt/trilinos/download_trilinos.sh
#RUN /opt/trilinos/download_trilinos.sh
#COPY trilinos-12.8.1-Source.tar.gz /home/$username
#RUN mv /opt/trilinos/trilinos-12.8.1-Source.tar.gz /opt/trilinos/trilinos.tar.gz

##extract trilinos source file
RUN tar xf /opt/trilinos/trilinos.tar.gz -C /opt/trilinos/
RUN rm -f /opt/trilinos/trilinos.tar.gz
RUN mv /opt/trilinos/trilinos-12.8.1-Source /opt/trilinos/trilinos
RUN mkdir /opt/trilinos/trilinos-build

#This package built modules. This is kind of weird, but for now let's go with it.
RUN module load mpi 

#######################

# Set user for VNC server (USER is only for build)
#ENV USER $username

# Copy xstartup file
#COPY Xclients /home/$username/.Xclients 
#COPY password.txt /home/$username
#RUN chown -R $username: /home/$username

# Copy VNC script that handles restarts
#COPY vnc.sh /opt/
#RUN chown $username: /opt/vnc.sh

# Expose VNC port
#EXPOSE 5901

########################
# switch to user
########################
#USER $username

# Set default password
#RUN cat password.txt password.txt | vncpasswd && \
#  rm password.txt

#CMD ["/opt/vnc.sh"]

########################
## compile trilinos
# must be run as user!
#RUN /opt/trilinos/install_trilinos.sh

WORKDIR /opt/trilinos

RUN /opt/trilinos/do-configure
RUN cd /opt/trilinos/trilinos-build && make 

########################

