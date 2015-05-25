FROM fedora:rawhide

RUN yum clean all && yum -y update && yum -y install devassistant-cli python3-jsonschema && yum clean all

RUN da pkg install nulecule
