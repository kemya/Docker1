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

RUN mkdir pasa
WORKDIR pasa
#get PASA itself
RUN git clone https://github.com/PASApipeline/PASApipeline.git && cd PASApipeline
RUN make


# get gmap
ADD http://research-pub.gene.com/gmap/src/gmap-gsnap-2016-07-11.tar.gz ./
RUN tar -xzvf *.tar.gz && rm *.tar.gz && mv gmap-gsnap* gmap-gsnap && cd gmap-gsnap && ./configure && make && make check

# get BLAT
RUN mkdir blat
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/* ./blat
#blat is pretty tricky. i seem to remember you have to change $MACHTYPE for it to work.
#ex. echo $MACHTYPE -> x86_64-redhat-linux-gnu
#has to become the short version x86_64 [to check]


#get FASTA
RUN mkdir FASTA
RUN wget http://faculty.virginia.edu/wrpearson/fasta/CURRENT/fasta-36.3.8d-linux64.tar.gz
#RUN tar -zxvf fasta-36.3.8d-linux64.tar.gz 
#this is the precompiled for linux 64. is this what i want or do I prefer to compile myself?
#also i remember from the past that somehow you need to change the name to the main command from fasta[somenumber] to fasta


#get mysql

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:`WORKDIR`/gmap-gsnap:`WORKDIR`/blat:`WORKDIR`/PASApipeline
