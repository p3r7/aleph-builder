# aleph-builder

monome aleph builder docker image


## usage

if running on `aarm` (Apple ARM) w/ [colima](https://github.com/abiosoft/colima), you'd need to install i386 emulation support w/ (see [#989](https://github.com/abiosoft/colima/issues/989)):

    docker run --privileged --rm tonistiigi/binfmt --install 386

you'd need to do this after every fresh `colima start`.

then run:

    docker run -it --rm --platform linux/amd64 aleph-builder
    git clone --recursive https://github.com/monome/aleph


build a blackfin binary (`waves` DSP module):

    cd ~/aleph/modules/waves
    make deploy


build an AVR32 binary (`bees` app):

    cd ~/aleph/apps/bees
    make


## image build

    docker build -t aleph-builder  .


## implementation details

Atmel AVR32 headers & toolchain are now hosted without a register wall but their server doesn't bans wget's user-agent so we fake ourselves as firefox.
