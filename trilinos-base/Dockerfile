# build docker container using
#   docker build -t tawiesn/trilinos-base .
# Add
#   --build-arg TRILINOS_VERSION=12.8.1
#   --build-arg CONFIGFILE=do-configure-release.sh
# to choose a specific Trilinos version or configuration file
# run the container using
#   docker run -i -t tawiesn/trilinos-base /bin/bash
# This image contains a basic CentOS with a standard development environment
# (compilers, MPI, ...)
#

#Build from the TPL image
FROM tawiesn/dev-tpl

#Take in build arguments
ARG TRILINOS_VERSION=12.8.1

ARG CONFIGFILE=do-configure-release.sh

#########################    

#We're building in /opt now
WORKDIR /opt/trilinos

# copy files to image
COPY $CONFIGFILE /opt/trilinos/do-configure

# download trilinos source tarball
RUN wget -nv https://trilinos.org/oldsite/download/files/trilinos-$TRILINOS_VERSION-Source.tar.gz -O /opt/trilinos/trilinos.tar.gz

##extract trilinos source file
RUN tar xf /opt/trilinos/trilinos.tar.gz -C /opt/trilinos/
RUN rm -f /opt/trilinos/trilinos.tar.gz
RUN mv /opt/trilinos/trilinos-$TRILINOS_VERSION-Source /opt/trilinos/trilinos
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
RUN /opt/trilinos/do-configure
RUN cd /opt/trilinos/trilinos-build && make -j 3 && make install
RUN rm -Rf /opt/trilinos/trilinos-build

# Set workdir to trilinos installation dir
WORKDIR /opt/trilinos/trilinos-install/

########################


