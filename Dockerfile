FROM alpine:3.19 AS downloader

RUN apk add wget

workdir /

RUN wget --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" http://www.atmel.com/Images/avr32-gnu-toolchain-3.4.2.435-linux.any.x86.tar.gz

RUN wget --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" http://www.atmel.com/Images/atmel-headers-6.1.3.1475.zip


FROM --platform=linux/amd64 ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y; \
    apt install -y gcc build-essential gcc-multilib lib32z1 \
    unzip udisks2 git wget

## NB: on ubuntu 20.04, wget is in version 1.20.3 and striked by atmel's website even when setting user-agent
## that's why we rely on another image to dl

COPY --from=downloader /avr32-gnu-toolchain-3.4.2.435-linux.any.x86.tar.gz /opt/avr32-gnu-toolchain-3.4.2.435-linux.any.x86.tar.gz
COPY --from=downloader /atmel-headers-6.1.3.1475.zip /opt/atmel-headers-6.1.3.1475.zip

WORKDIR /opt

RUN tar -xzf avr32-gnu-toolchain-3.4.2.435-linux.any.x86.tar.gz && \
    mv avr32-gnu-toolchain-linux_x86/ ~/avr32-gnu-toolchain

RUN unzip atmel-headers-6.1.3.1475.zip && \
    cp atmel-headers-6.1.3.1475/avr/ ~/avr32-gnu-toolchain/avr32/include -R && \
    cp atmel-headers-6.1.3.1475/avr32/ ~/avr32-gnu-toolchain/avr32/include -R

WORKDIR /

RUN wget https://downloads.sourceforge.net/project/adi-toolchain/2014R1/2014R1-RC2/i386/blackfin-toolchain-elf-gcc-4.3-2014R1-RC2.i386.tar.bz2 && \
    tar -xjvf blackfin-toolchain-elf-gcc-4.3-2014R1-RC2.i386.tar.bz2

RUN echo 'export PATH=$PATH:~/avr32-gnu-toolchain/bin' >> ~/.bashrc
RUN echo 'export PATH=$PATH:/opt/uClinux/bfin-elf/bin' >> ~/.bashrc

WORKDIR /root
