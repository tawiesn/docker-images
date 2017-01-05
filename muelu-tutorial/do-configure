#!/bin/sh

CONFIG_NAME=$(basename $0 .sh)

TRILINOS_HOME=/opt/trilinos/trilinos
BUILD_DIR=/opt/trilinos/trilinos-build/
INSTALL_DIR=/opt/trilinos/trilinos-install/

SUPERLU_DIR=/opt/tpls/SuperLU_4.3
PARMETISDIR=/opt/tpls/parmetis-4.0.3/build
NETCDF=/opt/tpls/netcdf-c-4.3.1.1/build
HDF5DIR=/opt/tpls/hdf5-1.8.9/build
BOOSTDIR=/opt/tpls/boost/build

# comments:
# SuperLu not working (fPIC problem)

EXTRA_ARGS=$@

if [ -e $BUILD_DIR ]; then 
    echo Error: $BUILD_DIR already exist. 
fi

mkdir -p $BUILD_DIR
cd $BUILD_DIR


# create a trilinos-version file which contains the git hash of the last commit
pushd $TRILINOS_HOME
echo `git log -n 1| head -n 3` > $BUILD_DIR/trilinos-version
popd


cmake \
-D CMAKE_BUILD_TYPE:STRING=DEBUG \
-D CMAKE_AR="/usr/bin/ar" \
-D BUILD_SHARED_LIBS:BOOL=ON \
-D CMAKE_CXX_FLAGS:STRING="-O2 -funroll-loops -ansi -pedantic -ftrapv -Wall -Wno-unused-local-typedefs -Wno-long-long -Wno-strict-aliasing -DBOOST_NO_HASH -DSKIP_DEPRECATED_STK_MESH_TOPOLOGY_HELPERS" \
-D CMAKE_VERBOSE_MAKEFILE:BOOL=OFF \
-D CMAKE_SKIP_RULE_DEPENDENCY=ON \
-D CMAKE_INSTALL_PREFIX:PATH=${INSTALL_DIR} \
-D Trilinos_VERBOSE_CONFIGURE:BOOL=OFF \
-D Trilinos_ENABLE_STRONG_CXX_COMPILE_WARNINGS=OFF \
-D Trilinos_ENABLE_STRONG_C_COMPILE_WARNINGS=OFF \
-D Trilinos_ENABLE_SHADOW_WARNINGS=OFF \
\
-D Trilinos_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
-D Trilinos_ENABLE_INSTALL_CMAKE_CONFIG_FILES:BOOL=OFF \
-D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
-D Trilinos_ENABLE_TESTS:BOOL=OFF \
-D Trilinos_ENABLE_DEBUG=OFF \
-D Trilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
-D Trilinos_ENABLE_ALL_OPTIONAL_PACKAGES:BOOL=OFF \
\
-D Trilinos_ENABLE_OpenMP:BOOL=OFF \
-D Trilinos_ENABLE_KokkosCore:BOOL=ON \
-D Trilinos_ENABLE_KokkosAlgorithms:BOOL=ON \
-D Trilinos_ENABLE_MueLu:BOOL=ON  \
-D MueLu_ENABLE_DEBUG:BOOL=ON \
-D Trilinos_ENABLE_Tpetra:BOOL=ON \
-D Trilinos_ENABLE_Epetra:BOOL=ON \
-D Trilinos_ENABLE_EpetraExt:BOOL=ON \
-D Trilinos_ENABLE_Isorropia:BOOL=ON  \
-D Trilinos_ENABLE_Ifpack:BOOL=ON \
-D Trilinos_ENABLE_Zoltan:BOOL=ON  \
-D Trilinos_ENABLE_Zoltan2:BOOL=ON  \
-D Trilinos_ENABLE_Teko:BOOL=OFF \
-D Trilinos_ENABLE_Belos:BOOL=ON \
-D Trilinos_ENABLE_AztecOO:BOOL=ON \
-D Trilinos_ENABLE_Panzer:BOOL=OFF \
-D Trilinos_ENABLE_Shards:BOOL=OFF \
-D Trilinos_ENABLE_Sacado:BOOL=OFF \
-D Trilinos_ENABLE_Intrepid:BOOL=OFF \
-D Trilinos_ENABLE_Stratimikos:BOOL=OFF \
-D Stratimikos_ENABLE_TESTS:BOOL=OFF \
-D Stratimikos_ENABLE_EXAMPLES:BOOL=OFF \
-D Trilinos_ENABLE_ML:BOOL=ON \
-D Trilinos_ENABLE_Amesos:BOOL=ON \
-D Trilinos_ENABLE_Amesos2:BOOL=ON \
-D Trilinos_ENABLE_Galeri:BOOL=ON \
-D Trilinos_ENABLE_Ifpack2:BOOL=ON \
\
-D MueLu_ENABLE_TESTS:BOOL=ON \
-D MueLu_ENABLE_EXAMPLES:BOOL=ON \
-D MueLu_ENABLE_Experimental:BOOL=ON \
-D Xpetra_ENABLE_Experimental:BOOL=ON \
-D Xpetra_ENABLE_TESTS:BOOL=ON \
-D Xpetra_ENABLE_EXAMPLES:BOOL=ON \
-D EpetraExt_ENABLE_HDF5:BOOL=OFF \
-D Teuchos_ENABLE_LONG_LONG_INT:BOOL=ON \
-DTPL_ENABLE_X11:BOOL=OFF \
-D Trilinos_ENABLE_EXPLICIT_INSTANTIATION=ON \
-D Teuchos_ENABLE_COMPLEX=OFF \
-D Teuchos_ENABLE_LONG_LONG_INT=OFF \
-D Tpetra_INST_INT_INT=O \
-D Tpetra_INST_INT_UNSIGNED=OFF \
-D Tpetra_INST_INT_LONG=OFF \
-D Tpetra_INST_INT_LONG_LONG=OFF \
-D Tpetra_INST_DOUBLE=ON \
-D Tpetra_INST_FLOAT=OFF \
-D Tpetra_INST_COMPLEX_DOUBLE=OFF \
-D Tpetra_INST_COMPLEX_FLOAT=OFF \
-D Tpetra_INST_SERIAL=ON \
-D Tpetra_INST_OPENMP:BOOL=OFF \
-D Kokkos_ENABLE_Serial:BOOL=ON \
-D Kokkos_ENABLE_OpenMP:BOOL=OFF \
-D Kokkos_ENABLE_Pthread:BOOL=OFF \
-D Xpetra_Epetra_NO_32BIT_GLOBAL_INDICES=OFF \
-D Xpetra_Epetra_NO_64BIT_GLOBAL_INDICES=ON \
\
-DTPL_ENABLE_MPI=ON \
\
-D TPL_ENABLE_BoostLib:BOOL=ON \
-D TPL_ENABLE_BoostAlbLib:BOOL=ON \
-D Boost_INCLUDE_DIRS:FILEPATH=$BOOSTDIR/include \
-D Boost_LIBRARY_DIRS:FILEPATH=$BOOSTDIR/lib \
-D BoostLib_INCLUDE_DIRS:FILEPATH=$BOOSTDIR/include \
-D BoostLib_LIBRARY_DIRS:FILEPATH=$BOOSTDIR/lib \
-D BoostAlbLib_INCLUDE_DIRS:FILEPATH=$BOOSTDIR/include \
-D BoostAlbLib_LIBRARY_DIRS:FILEPATH=$BOOSTDIR/lib \
\
-D TPL_ENABLE_HDF5:BOOL=ON \
-D HDF5_INCLUDE_DIRS:PATH=$HDF5DIR/include \
-D HDF5_LIBRARY_DIRS:PATH=$HDF5DIR/lib \
\
-D TPL_ENABLE_Netcdf:BOOL=ON \
-D TPL_Netcdf_INCLUDE_DIRS:PATH=$NETCDF/include \
-D Netcdf_LIBRARY_DIRS:PATH=$NETCDF/lib \
\
-D TPL_ENABLE_ParMETIS:STRING=OFF \
-D ParMETIS_INCLUDE_DIRS:PATH=$PARMETISDIR/include \
-D ParMETIS_LIBRARY_DIRS:PATH=$PARMETISDIR/lib \
\
-D TPL_ENABLE_SuperLU:BOOL=OFF \
-D TPL_SuperLU_LIBRARY_DIRS="$SUPERLU_DIR/build-drekar/lib" \
-D TPL_SuperLU_INCLUDE_DIRS="$SUPERLU_DIR/build-drekar/include" \
-D TPL_SuperLU_LIBRARIES="$SUPERLU_DIR/build-drekar/lib/libsuperlu_4.3.a" \
-D Amesos2_ENABLE_KLU2:BOOL=ON \
\
-D TPL_ENABLE_BLAS:BOOL=ON \
-D TPL_BLAS_LIBRARIES:FILEPATH="/usr/lib64/libblas.so.3" \
-D TPL_ENABLE_LAPACK:BOOL=ON \
-D TPL_LAPACK_LIBRARIES:FILEPATH="/usr/lib64/liblapack.so.3" \
\
$EXTRA_ARGS \
${TRILINOS_HOME}
