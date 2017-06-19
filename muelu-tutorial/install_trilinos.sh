#!/bin/bash -i

# create folder structure and move files to correct place
TRILINOS_SRCDIR=/opt/trilinos
TRILINOS_BUILDDIR=/opt/trilinos-build

TPL_BASEDIR=/opt/tpls

## load MPI module
#echo "Load MPI module"
#module load mpi/openmpi-x86_64

## run configuration
#cd ~
./do-configure

## build trilinos
cd $TRILINOS_BUILDDIR
make -j 4
cd ~

## copy MueLu tutorial data
ln -s ~/trilinos-build/packages/muelu/doc/Tutorial/src muelu-tutorial
