# docker-images
A collection of Dockerfiles for different Trilinos-related projects.

- **dev-base:** base image derived from CentOS. Contains basic development tools (such as gcc, cmake, ...).
- **dev-tpl:**  Image installs some important third-party libraries from source, that are useful/necessary for Trilinos.
- **trilinos-base:** Image installs Trilinos in /opt/trilinos/trilinos-install. The user can select the Trilinos version (default 12.8.1) and provide a configuration file for Trilinos.
- **muelu-tutorial-new:** Image containing the MueLu tutorial executables. Example how to derive an application image from *trilinos-base*
- **baci-promotion:** Incomplete image containing a Trilinos installation from 2014. Can be used to compile BACI (version from 2014) and reproduce results from the thesis [Flexible Aggregation-based Algebraic Multigrid Methods for Contact and Flow Problems](http://mediatum.ub.tum.de/doc/1229321/1229321.pdf)
- **jupyter-cling-centos:** Image containing a Trilinos installation (Epetra, Xpetra, MueLu,...) with jupyter and cling interactive C++ kernel. It contains MueLu and Xpetra interactive training lessons. See [here](http://www.tawiesn.de/blog/?x=entry:entry170408-231332) for more information.
