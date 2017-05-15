FROM centos:centos6
MAINTAINER Baris Bilgic <baris@jooysoft.com>


RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all

RUN yum -y install python-devel python-pip nginx nodejs npm libxslt-devel libxml2-devel  openldap-devel redis
RUN yum -y install openssl098e  mysql-server mysql MySQL-python pwgen supervisor bash-completion psmisc net-tools wget
RUN yum -y install compat-openldap httpd-devel apr-devel
RUN yum -y install mysql-devel
RUN yum clean all 

# Install python2.7
RUN cd /tmp && \
    wget https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz && \
    tar xvfz Python-2.7.8.tgz && \
    cd Python-2.7.8 && \
    ./configure --prefix=/usr/local && \
    make && \
    make altinstall

# Install setuptools + pip
RUN cd /tmp && \
    wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz && \
    tar -xvf setuptools-1.4.2.tar.gz && \
    cd setuptools-1.4.2 && \
    python2.7 setup.py install && \
    curl https://bootstrap.pypa.io/get-pip.py | python2.7 - && \
    pip install virtualenv

ADD ./start.sh /start.sh
ADD ./config_mysql.sh /config_mysql.sh
ADD ./supervisord.conf /etc/supervisord.conf

RUN chmod 755 /start.sh
RUN chmod 755 /config_mysql.sh
RUN /config_mysql.sh

EXPOSE 3306

CMD ["/bin/bash", "./start.sh"]
