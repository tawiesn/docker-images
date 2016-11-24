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
RUN yum update; \
    yum -y install htop xterm nano; \
    yum -y install openbox; \
    yum -y install tightvnc-server; \
    yum clean all

#########################    
    
RUN yum update; \
    yum -y install doxygen; \
    yum -y install gnuplot; \
    yum -y install gedit; \
    yum -y install xfce4-terminal; \
    yum clean all;

# create user (but run the commands as root)
RUN adduser $username
WORKDIR /home/$username

# copy files to image
COPY download_trilinos.sh /home/$username/
COPY install_trilinos.sh /home/$username/
COPY do-configure /home/$username/

# copy or download trilinos source files
WORKDIR /home/$username
RUN chmod 750 download_trilinos.sh
RUN ./download_trilinos.sh
#COPY trilinos-12.8.1-Source.tar.gz /home/$username
RUN mv trilinos-12.8.1-Source.tar.gz trilinos.tar.gz

##extract trilinos source file
RUN tar xvf trilinos.tar.gz
RUN rm -f trilinos.tar.gz
RUN mv trilinos-12.8.1-Source trilinos
RUN mkdir trilinos-build

# switch to new user
RUN chown -R $username: /home/$username
RUN echo 'module load mpi/openmpi-x86_64' >> /home/$username/.bash_profile

#######################

# Set user for VNC server (USER is only for build)
ENV USER $username

# Copy xstartup file
COPY Xclients /home/$username/.Xclients 
COPY password.txt /home/$username
RUN chown -R $username: /home/$username

# Copy VNC script that handles restarts
COPY vnc.sh /opt/
RUN chown $username: /opt/vnc.sh

# Expose VNC port
EXPOSE 5901

########################
# switch to user
########################
USER $username

# Set default password
RUN cat password.txt password.txt | vncpasswd && \
  rm password.txt

CMD ["/opt/vnc.sh"]

########################
## compile trilinos
# must be run as user!
RUN ./install_trilinos.sh

########################

