
FROM 	rinnocente/ubuntu-17.04-homebrewed
#
LABEL 	maintainer="Roberto Innocente <inno@sissa.it>" \
	version="1.0"
#
ARG DEBIAN_FRONTEND=noninteractive
#
ENV  	QE_HD="/home/qe" \
 	QE_VER="-6.1"


# we create the user 'qe' and add it to the list of sudoers
RUN  \
	adduser -q --disabled-password --gecos qe qe          \
	&& printf "\nqe ALL=(ALL:ALL) NOPASSWD:ALL\n" >>/etc/sudoers.d/qe \
	&& (echo "qe:mammamia" | chpasswd) \
	&& echo "export OMP_NUM_THREADS=1" >>/home/qe/.bashrc \
	&& echo export PATH=/home/qe/qe"${QE_VER}"/bin:"${PATH}" >>/home/qe/.bashrc 
#

WORKDIR "$QE_HD"
#
RUN \ 
	wget http://qe-forge.org/gf/download/frsrelease/240/1075/qe"${QE_VER}".tar.gz \
	&& wget http://qe-forge.org/gf/download/frsrelease/240/1073/qe"${QE_VER}"-test-suite.tar.gz \
	&& wget http://qe-forge.org/gf/download/frsrelease/240/1072/qe"${QE_VER}"-examples.tar.gz \
	&& tar xzf qe"${QE_VER}".tar.gz  
#
RUN 	\
	(cd qe"${QE_VER}" || exit  ; \
		./configure ; \
		make all ; \
		tar xzf ../qe"${QE_VER}"-test-suite.tar.gz ; \
		tar xzf ../qe"${QE_VER}"-examples.tar.gz  ) 
RUN	\
	mkdir -p downloads \
	&& mv  qe"${QE_VER}".tar.gz  qe"${QE_VER}"-test-suite.tar.gz  qe"${QE_VER}"-examples.tar.gz downloads/
#
RUN 	\
	chown -R qe:qe "${QE_HD}"
#
USER qe
#
CMD 	["sudo","sshd","-D"]

