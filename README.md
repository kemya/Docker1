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

also while i'm at it i might also point out that for this to actually work once mysql is installed
it needs to create 2 users one with read and write rights and one with read only rights
#enter mysql
mysql -u username -p
#create users

#grant privileges
GRANT ALL PRIVILEGES ON * . * TO 'RW-rights-user'@'localhost';
GRANT SELECT ON * . * TO 'RO-rights-user'@'localhost';
FLUSH PRIVILEGES;
