# aleph-builder

monome aleph builder docker image


## usage

    docker run -it --rm --platform linux/amd64 aleph-builder
    git clone --recursive https://github.com/monome/aleph

    cd ~/aleph/modules/waves
    make deploy

    cd ~/aleph/apps/bees
    make


## build

    docker build -t aleph-builder  .
    docker build -t aleph-builder-old  .


## notes

Atmel AVR32 headers & toolchain are now hosted without a register wall but their server doesn't bans wget's user-agent so we fake ourselves as firefox.
