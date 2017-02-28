# build docker container using
#   docker build --build-arg username=tutorial -t tawiesn/muelu-tutorial-new .
# run the container using
#   docker run -i -t tawiesn/muelu-tutorial /bin/bash
#   docker run -dP -p 5901:5901 tawiesn/muelu-tutorial
# This image contains a basic CentOS with a standard development environment
# (compilers, MPI, ...)
#
FROM tawiesn/trilinos-base
ARG username=tutorial

#Take in build arguments
ARG TRILINOS_VERSION=12.8.1

#########################    

#We're building in /opt now
WORKDIR /opt/trilinos

# copy files to image
COPY do-configure-tutorial /opt/trilinos/

# note: we expect the Trilinos sources being extracted to /opt/trilinos

# create build directory
RUN mkdir /opt/trilinos/trilinos-build

#This could be done in modules, but lets be explicit 
#RUN module load mpi 
env PATH /usr/lib64/openmpi/bin:$PATH
env LD_LIBRARY_PATH /usr/lib64/openmpi/lib:$LD_LIBRARY_PATH
env PYTHONPATH /usr/lib64/python2.7/site-packages/openmpi:$PYTHONPATH
env MANPATH /usr/share/man/openmpi-x86_64:$MANPATH
env MPI_BIN /usr/lib64/openmpi/bin
env MPI_SYSCONFIG /etc/openmpi-x86_64
env MPI_FORTRAN_MOD_DIR /usr/lib64/gfortran/modules/openmpi-x86_64
env MPI_INCLUDE /usr/include/openmpi-x86_64
env MPI_LIB /usr/lib64/openmpi/lib
env MPI_MAN /usr/share/man/openmpi-x86_64
env MPI_PYTHON_SITEARCH /usr/lib64/python2.7/site-packages/openmpi
env MPI_COMPILER openmpi-x86_64
env MPI_SUFFIC _opemmpi
env MPI_HOME /usr/lib64/openmpi


########################

## compile trilinos
RUN /opt/trilinos/do-configure-tutorial
RUN cd /opt/trilinos/trilinos-build && make -j 3 

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


#Link to the Trilinos directory
RUN ln -s /opt/trilinos/trilinos-build/packages/muelu/doc/Tutorial/src /home/$username/muelu-tutorial

