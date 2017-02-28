# build docker container using
#   docker build -t ajyounge/muelu-tutorial .
# run the container using
#   docker run -i -t ajyounge/muelu-tutorial /bin/bash
# This image contains a basic CentOS with a standard development environment
# (compilers, MPI, ...)
# The VNC service has been removed, but can be added upon request.
#

#Build from the TPL image
FROM tawiesn/dev-tpl


#Take in build arguments
ARG TRILINOS_VERSION=12.8.1


#########################    

#We're building in /opt now
WORKDIR /opt/trilinos

# copy files to image
COPY do-configure /opt/trilinos/

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
RUN cd /opt/trilinos/trilinos-build && make -j 3 

#Link in a tutorial directory, and then set the workdir
#RUN ln -s /opt/trilinos/trilinos-build/packages/muelu/doc/Tutorial/src /opt/muelu-tutorial

#Set the workdir to the tutorial
WORKDIR /opt/muelu-tutorial


########################


