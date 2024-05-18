# aleph-builder

monome aleph builder docker image based on Ubuntu 24.04 LTS.


## image build

    docker build -t aleph-builder  .


## usage

run:

    docker run -it --rm --name aleph-builder aleph-builder
    git clone --recursive https://github.com/monome/aleph

build a blackfin binary (`waves` DSP module):

    cd ~/aleph/modules/waves
    make deploy

build an AVR32 binary (`bees` app):

    cd ~/aleph/apps/bees
    make


#### note for Apple ARM / colima

if running on `aarm` (Apple ARM) w/ [colima](https://github.com/abiosoft/colima), you'd need to install i386 emulation support w/ (see [#989](https://github.com/abiosoft/colima/issues/989)):

    docker run --privileged --rm tonistiigi/binfmt --install 386

you'd need to do this after every fresh `colima start`.

likewise, to prevent docker complaining about platform mismatch, you can pass the `--platform linux/amd64` option when `docker run`ning the aleph-builder container.


#### emacs

i typically precise a container name w/ e.g. `--name aleph-builder`.

this allows me to jump directly in the container w/ TRAMP:

    /docker:aleph-builder:~/

my typicall launch command is:

    docker run -it --rm --platform linux/amd64 -v ~/Documents/code/monome/aleph:/root/aleph --name aleph-builder aleph-builder


## implementation details

Atmel AVR32 headers & toolchain are now hosted without a register wall but their server blocks wget's user-agent so we fake ourselves as firefox.
