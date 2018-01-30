Apache Zeppelin image for OpenShift
-----------------------------------

Source code to build and run [Apache Zeppelin](http://zeppelin.apache.org/) on top of
[OpenShift](https://www.openshift.org/). This image used [dogen](https://github.com/jboss-dockerfiles/dogen)
to generate the environment to build the Docker image. To build the image, run the following commands:

```
$ docker run -it --rm -v $(pwd):/tmp:z jboss/dogen:latest --verbose /tmp/image.yaml /tmp/out
$ pushd out; docker build -t <username>/zeppelin-openshift .; popd
```

