
FROM rinnocente/ubuntu-17.04-homebrewed

LABEL maintainer="Roberto Innocente <inno@sissa.it>" \
	version="1.0"

ARG DEBIAN_FRONTEND=noninteractive
#
ENV  QE_HD="/home/qe"  \
	QE_VER="-6.1"


# we create the user 'gromed' and add it to the list of sudoers
RUN  adduser -q --disabled-password --gecos qe qe          \
	&& echo "\nqe ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers.d/gromed  \
	&& (echo "qe:mammamia"|chpasswd) \
	# to avoid that ubuntu openblas tries to use multithreading that conflicts with mpi
	&& echo "export OMP_NUM_THREADS=1" >>/home/qe/.bashrc \
# we add /home/qe to the PATH of user 'qe'
	&& echo "export PATH=/home/qe/qe${QE_VER}/bin:${PATH}" >>/home/qe/.bashrc \
	&& mkdir -p /home/qe/.ssh/  
#

WORKDIR "$QE_HD"


RUN wget http://qe-forge.org/gf/download/frsrelease/240/1075/qe${QE_VER}.tar.gz \
	&& wget http://qe-forge.org/gf/download/frsrelease/240/1073/qe${QE_VER}-test-suite.tar.gz \
	&& wget http://qe-forge.org/gf/download/frsrelease/240/1072/qe${QE_VER}-examples.tar.gz \
	&& tar xzf qe${QE_VER}.tar.gz  
RUN 	(cd qe${QE_VER} ; \
		./configure ; \
		make all ) 

RUN chown -R qe:qe ${QE_HD}

USER qe

CMD ["sudo","sshd","-D"]






