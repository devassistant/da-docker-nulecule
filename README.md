# DevAssistant Runnable Docker Image for Nulecule

Copyright 2015 Tomas Radej <tradej@redhat.com>

This image contains the DevAssistant CLI and a Nulecule DAP with dependencies.
It is for testing purposes only, and may break at any time. Use at your own
risk!

Distributed under the terms of the MIT license.


## Usage

You can now download this from Docker Hub with "docker pull devassistant/nulecule". Once you do that, you can run it with:

```
docker run -it --rm --privileged --name da -u `id -u $USER` -v `echo $HOME`:/home/dev -v `pwd`:/project devassistant/nulecule
```

or, you can pass commands directly to it:

```
docker run -it --rm --privileged --name da -u `id -u $USER` -v `echo $HOME`:/home/dev -v `pwd`:/project devassistant/nulecule create -n myapp
```
