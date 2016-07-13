#################################################################
# Dockerfile
#
# Version:          1
# Software:         PASApipeline
# Software Version: 2.0.2
# Documentation:    http://pasa.sf.net
# Website:          https://github.com/PASApipeline/PASApipeline.git
# Tags:             Genomics Annotation
# Dependencies:     BLAT FASTA gmap perl mysql
# Base Image:       ubuntu:14.04
# Build Cmd:        docker build --rm -t <img>
# Pull Cmd:         docker pull <img>
# Run Cmd:          docker run --rm -it <img> <options> <files>
#################################################################

# start from base
FROM ubuntu:14.04
MAINTAINER stef.bertazzoni@gmail.com
# install system-wide stuff
RUN apt-get update
RUN apt-get install -y build-essential wget gcc make
RUN apt-get install -qqy libopenmpi-dev
#missing perl
#missing perl module DBD::mysql


WORKDIR /tmp
#get PASA itself
RUN git clone https://github.com/PASApipeline/PASApipeline.git && cd PASApipeline
RUN make


# get gmap
ADD http://research-pub.gene.com/gmap/src/gmap-gsnap-2016-07-11.tar.gz ./
RUN tar -xzvf *.tar.gz && rm *.tar.gz && mv gmap-gsnap* gmap-gsnap && cd gmap-gsnap && ./configure && make && make check
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/tmp/gmap-gsnap

# get BLAT


#get FASTA
#[to check]#RUN wget http://faculty.virginia.edu/wrpearson/fasta/CURRENT/fasta-36.3.8d-linux64.tar.gz
#this is the precompiled for linux 64. is this what i want or do I prefer to compile myself?
#[to check]#RUN tar zxvf fasta-36.3.8d-linux64.tar.gz 
#[to check]#WORKDIR fasta-36.3.8d-linux64

#get mysql
