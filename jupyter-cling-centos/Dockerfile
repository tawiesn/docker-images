# docker run --rm -it -P -v /path/to/workspace:/workspace -v /path/to/mnt:/mnt skwbc/cling-notebook
# run with 
#   docker run --rm -it -p 192.168.99.100:8888:8888 -P tawiesn/jupyter-cling-centos
#   docker run --rm -it -p 192.168.99.100:8888:8888 -v /Users/tawiesn/workspace:/workspace -P tawiesn/jupyter-cling-centos /bin/bash
# access through 
#   192.168.99.100:8888
# https://hub.docker.com/r/skwbc/cling-notebook/
FROM centos:latest
MAINTAINER Tobias Wiesner <wiesner.t@web.de>

RUN set -x && \
    yum update; \
    yum -y install build-essential; \
    yum -y install make; \
    yum -y install git; \
    yum -y install python; \
    yum -y install python-devel; \
    yum -y install python2-pip; \
    yum -y install wget; \
    yum -y install vim; \    
    yum clean all;

RUN yum -y install less epel-release htop environment-modules wget nano
RUN yum -y install gcc gcc-gfortran gcc-c++
RUN yum -y install openmpi openmpi-devel hdf5 hdf5-devel hdf5-openmpi hdf5-openmpi-devel
RUN yum -y install netcdf netcdf-devel netcdf-openmpi-devel netcdf-openmpi
RUN yum -y install blas blas-devel lapack lapack-devel boost boost-devel atlas atlas-devel

RUN yum -y install cmake3

RUN cp /usr/bin/cmake3 /usr/bin/cmake

# copy cling installation script from cern
COPY clone.sh /root/clone.sh
RUN chmod u+x /root/clone.sh


RUN set -x && \
  /root/clone.sh

RUN yum -y install python2-pip;

RUN set -x
RUN pip install jupyter
RUN pip install --upgrade pip
WORKDIR /opt/clang/share/cling/Jupyter/kernel
RUN pip install -e .
RUN jupyter-kernelspec install cling-cpp17
RUN jupyter-kernelspec install cling-cpp14
RUN jupyter-kernelspec install cling-cpp11
ENV PATH /inst/bin:$PATH

# copy notebook configuration file
COPY jupyter_notebook_config.py /root/.jupyter/
EXPOSE 8888 

RUN yum -y install texlive-collection-xetex texlive-adjustbox texlive-upquote texlive-eurosym texlive-ucs texlive-collection-latexrecommended
RUN yum -y install pandoc pandoc-pdf

RUN mkdir /workspace
WORKDIR /workspace

#COPY Trilinos-sandia.tar.gz /opt/Trilinos.tar.gz
WORKDIR /opt
RUN git clone https://github.com/trilinos/Trilinos.git
#RUN tar xvf Trilinos.tar.gz
#RUN mv Trilinos-sandia Trilinos
COPY do-conf-ep-serial /opt

RUN /opt/do-conf-ep-serial
RUN cd /opt/build/do-conf-ep-serial && make -j 3 
RUN cd /opt/build/do-conf-ep-serial && make install



env PATH /opt/clang/bin/:$PATH
env LD_LIBRARY_PATH /opt/install/do-conf-ep-serial/lib/:$LD_LIBRARY_PATH



# TODO compile and install trilinos
# set LD_LIBRARY_PATH
# ENV LD_LIBRARY_PATH=...
# run jupyter notebooks
# .I path to includes
#.I /opt/install/do-conf-ep-serial/include/
# .L libaztecoo

WORKDIR /workspace
COPY *.ipynb /workspace/


## Add Tini. Tini operates as a process subreaper for jupyter. This prevents
## kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
#ENTRYPOINT ["/usr/bin/tini", "--"]
ENTRYPOINT ["/usr/bin/tini", "jupyter", "notebook", "--"]

##EXPOSE 8888
##CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
