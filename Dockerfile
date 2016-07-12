# start from base
FROM ubuntu:14.04
# install system-wide stuff
RUN apt-get update
RUN apt-get install -y build-essential wget gcc make
#missing perl
#missing perl module DBD::mysql

#get PASA itself
RUN git clone https://github.com/PASApipeline/PASApipeline.git
WORKDIR PASApiepline
RUN make


# get gmap
RUN wget http://research-pub.gene.com/gmap/src/gmap-gsnap-2016-07-11.tar.gz
RUN tar zxvf gmap-gsnap-2016-07-11.tar.gz
WORKDIR gmap-gsnap-2016-07-11
RUN ./configure
RUN make
RUN make check


# get BLAT


#get FASTA
#[to check]#RUN wget http://faculty.virginia.edu/wrpearson/fasta/CURRENT/fasta-36.3.8d-linux64.tar.gz
#this is the precompiled for linux 64. is this what i want or do I prefer to compile myself?
#[to check]#RUN tar zxvf fasta-36.3.8d-linux64.tar.gz 
#[to check]#WORKDIR fasta-36.3.8d-linux64

#get mysql
