FROM --platform=linux/amd64 ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y; \
    apt install -y gcc build-essential gcc-multilib lib32z1 \
    unzip udisks2 git wget ripgrep fd-find

RUN ln -s /usr/bin/fdfind /usr/bin/fd

WORKDIR /opt

RUN wget --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" http://www.atmel.com/Images/avr32-gnu-toolchain-3.4.2.435-linux.any.x86.tar.gz && \
    tar -xzf avr32-gnu-toolchain-3.4.2.435-linux.any.x86.tar.gz && \
    mv avr32-gnu-toolchain-linux_x86/ ~/avr32-toolchain-linux

RUN wget --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" http://www.atmel.com/Images/atmel-headers-6.1.3.1475.zip && \
    unzip atmel-headers-6.1.3.1475.zip && \
    cp atmel-headers-6.1.3.1475/avr/ ~/avr32-gnu-toolchain/avr32/include -R && \
    cp atmel-headers-6.1.3.1475/avr32/ ~/avr32-gnu-toolchain/avr32/include -R

WORKDIR /

RUN wget https://downloads.sourceforge.net/project/adi-toolchain/2014R1/2014R1-RC2/i386/blackfin-toolchain-elf-gcc-4.3-2014R1-RC2.i386.tar.bz2 && \
    tar -xjvf blackfin-toolchain-elf-gcc-4.3-2014R1-RC2.i386.tar.bz2

RUN echo 'export PATH=$PATH:~/avr32-toolchain-linux/bin' >> ~/.bashrc
RUN echo 'export PATH=$PATH:/opt/uClinux/bfin-elf/bin' >> ~/.bashrc
RUN echo 'export LC_ALL=C' >> ~/.bashrc

WORKDIR /root
