![Docker build status](https://img.shields.io/docker/build/rimolive/zeppelin-openshift.svg)
![GitHub tag](https://img.shields.io/github/tag/rimolive/zeppelin-openshift.svg)

Apache Zeppelin image for OpenShift
-----------------------------------

Source code to build and run [Apache Zeppelin](http://zeppelin.apache.org/) on top of
[OpenShift](https://www.openshift.org/). This image uses [cekit](http://cekit.readthedocs.io)
to generate the environment to build the Docker image. To build the image, follow
[cekit installation guide](http://cekit.readthedocs.io/en/develop/installation.html#installing-cekit)
and run the following command:

```
$ make clean build
```

