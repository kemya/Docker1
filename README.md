# Docker1
My first attempt at dockerize stuff

# Project Outline
Themain goal is to create a Docker image containing PASA pipeline
(one of the trickiest softwares i've ever encountered installation-wise)

PASA requires to work:
* Pasa software
* BLAT
* GMAP
* MYSQL
* FASTA
* Perl module DBD::mysql

I'm not completely sure if with those many dependencies i should try to use docker-compose 
to have these guys playing well together
