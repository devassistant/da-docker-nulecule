FROM fedora:rawhide

RUN yum clean all && yum -y update && yum -y install devassistant-cli python3-jsonschema && yum clean all

RUN da pkg install nulecule

VOLUME /project
WORKDIR /project

LABEL INFO something seems to have changed about atomic (http://github.com/projectatomic/atomic), so the RUN LABEL is just for user reference
LABEL USER_BUILD docker build -t da .
LABEL USER_RUN docker run -it --rm --privileged -v `pwd`:/project --name da -e NAME=devassistant -e IMAGE=da da
#LABEL RUN docker run -it --rm --privileged -v `pwd`:/project --name NAME -e NAME=NAME -e IMAGE=IMAGE IMAGE

ENTRYPOINT ["/usr/bin/da"]
