FROM centos:7

RUN yum -y install https://www.softwarecollections.org/en/scls/rhscl/rh-python34/epel-7-x86_64/download/rhscl-rh-python34-epel-7-x86_64.noarch.rpm && \
    yum clean all
RUN yum -y update && yum -y install rh-python34 scl-utils && yum clean all
RUN scl enable rh-python34 "easy_install pip"
RUN scl enable rh-python34 "pip3 install devassistant"

RUN echo '#!/bin/sh' > /usr/local/bin/da-scl
RUN echo 'scl enable rh-python34 "da $*"' >> /usr/local/bin/da-scl
RUN chmod +x /usr/local/bin/da-scl
RUN scl enable rh-python34 "da pkg install nulecule"

RUN useradd dev
VOLUME /home/dev
VOLUME /project
RUN chown dev:dev -R /project
WORKDIR /project

USER dev

LABEL RUN docker run -d --privileged  -u `id -u $USER` -v `echo $HOME`:/home/dev -v `pwd`:/project --name NAME -e NAME=NAME -e IMAGE=IMAGE --entrypoint=bash IMAGE -c \"tail -f /dev/null\"

LABEL USER_RUN docker run -it --rm --privileged --name da -u `id -u $USER` -v `echo $HOME`:/home/dev -v `pwd`:/project IMAGE

ENTRYPOINT ["/usr/local/bin/da-scl"]
