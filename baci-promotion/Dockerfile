# build docker container using
#   docker build --build-arg username=tawiesn -t tawiesn/baci-promotion .
# run the container using
#   docker run -i -t tawiesn/baci-promotion /bin/bash
# This image contains a basic CentOS with a standard development environment
# (compilers, MPI, ...)
#
FROM tawiesn/dev-base
ARG username=tawiesn


#########################    
    
RUN yum update; \
    yum groupinstall \"Development Tools\"; \
    yum install git-gui gitk; \
    yum install blas blas-devel lapack lapack-devel cmake; \
    yum install boost boost-devel; \
    yum clean all;

# create user (but run the commands as root)
RUN adduser $username
WORKDIR /home/$username

# copy files to image
COPY ParMetis.Makefile.in /home/$username/
COPY make.inc.superludist /home/$username/
COPY do-configure-trilinos /home/$username/
COPY SuiteSparse.UFconfig.mk /home/$username/
COPY baci.tar.gz /home/$username/


# switch to new user
RUN chown -R $username: /home/$username
RUN echo 'module load mpi/openmpi-x86_64' >> /home/$username/.bash_profile

#######################
########################
# switch to user
########################
USER $username

# fetch TPL packages
RUN wget http://www.open-mpi.org/software/ompi/v1.8/downloads/openmpi-1.8.4.tar.gz

RUN wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/OLD/ParMetis-3.1.1.tar.gz

RUN wget http://trilinos.org/oldsite/download/files/trilinos-11.12.1-Source.tar.gz

RUN wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-3.3.0.tar.gz

RUN wget http://crd-legacy.lbl.gov/~xiaoye/SuperLU/superlu_dist_2.5.tar.gz

RUN wget http://www.qhull.org/download/qhull-2012.1-src.tgz

RUN mkdir -p /home/$username/TPL
RUN mv *.tar.gz TPL
RUN mv *.tgz TPL

########################

WORKDIR /home/$username/TPL

########################
# install ParMetis

RUN tar xvfz ParMetis*.gz
WORKDIR /home/$username/TPL/ParMetis-3.1.1
RUN rm Makefile.in
RUN cp /home/$username/ParMetis.Makefile.in Makefile.in
RUN bash --login -c make

########################

WORKDIR /home/$username/TPL

########################
# install SuiteSparse
RUN tar xvfz SuiteSparse*.gz
WORKDIR /home/$username/TPL/SuiteSparse
RUN rm UFconfig/UFconfig.mk
RUN cp /home/$username/SuiteSparse.UFconfig.mk /home/$username/TPL/SuiteSparse/UFconfig/UFconfig.mk
RUN bash --login -c make

########################

WORKDIR /home/$username/TPL

########################

# collect headers and libs from SuiteSparse
RUN mkdir /home/$username/TPL/SuiteSparse/lib
RUN mkdir /home/$username/TPL/SuiteSparse/include

RUN cp -i /home/$username/TPL/SuiteSparse/*/Lib/*.a /home/$username/TPL/SuiteSparse/lib
RUN cp -i /home/$username/TPL/SuiteSparse/*/Include/* /home/$username/TPL/SuiteSparse/include

########################

WORKDIR /home/$username/TPL

########################
# install Trilinos

RUN tar xvf trilinos*.tar.gz
RUN mv trilinos-11.12.1-Source trilinos-source
RUN mkdir trilinos-build
RUN cp /home/$username/do-configure-trilinos /home/$username/TPL/trilinos-build/
WORKDIR /home/$username/TPL/trilinos-build/
RUN bash --login -c ./do-configure-trilinos
RUN bash --login -c make -j 4 && make install

########################

WORKDIR /home/$username/TPL

########################
# install QHULL

RUN tar xvf qhull*.tgz
WORKDIR /home/$username/TPL/qhull-2012.1/build
RUN echo cmake -D CMAKE_INSTALL_PREFIX:FILEPATH=/home/tawiesn/TPL /home/tawiesn/TPL/qhull-2012.1/ >> do-configure-qhull
RUN chmod 750 ./do-configure-qhull
RUN cat ./do-configure-qhull
RUN bash --login -c ./do-configure-qhull
RUN bash --login -c make && make install


COPY c7-promotion.config /home/$username/

#install 
# yum install python-lxml
