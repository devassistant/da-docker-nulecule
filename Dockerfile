FROM centos:7

RUN yum clean all && yum -y install wget && yum clean all
RUN wget https://www.softwarecollections.org/en/scls/rhscl/python33/epel-7-x86_64/download/rhscl-python33-epel-7-x86_64.noarch.rpm
RUN yum clean all && yum -y localinstall rhscl-python33-epel-7-x86_64.noarch.rpm && yum -y update && yum -y install python33 scl-utils && yum clean all
RUN scl enable python33 "easy_install pip"
RUN scl enable python33 "pip3 install devassistant"

RUN echo '#!/bin/sh' > /usr/local/bin/da
RUN echo 'scl enable python33 "da $*"' >> /usr/local/bin/da
RUN chmod +x /usr/local/bin/da
RUN scl enable python33 "da pkg install nulecule"

RUN useradd dev
VOLUME /home/dev
VOLUME /project
RUN chown dev:dev -R /project
WORKDIR /project

USER dev

LABEL RUN docker run -d --privileged  -u `id -u $USER` -v `echo $HOME`:/home/dev -v `pwd`:/project --name NAME -e NAME=NAME -e IMAGE=IMAGE --entrypoint=bash IMAGE -c \"tail -f /dev/null\"

LABEL USER_RUN docker run -it --rm --privileged --name da -u `id -u $USER` -v `echo $HOME`:/home/dev -v `pwd`:/project IMAGE

ENTRYPOINT ["/usr/local/bin/da"]
