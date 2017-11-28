FROM 		centos:7

ENV		JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk

ENV		JRE_HOME /usr/lib/jvm/jre
ENV		GRADLE_HOME /opt/gradle-2.14
ENV		GRADLE_BIN $GRADLE_HOME/bin
ENV		PATH $PATH:$GRADLE_BIN
ENV		APP_HOME /root/docker_SWT
ENV		APP_RUN	$APP_HOME/build/libs

RUN 		yum -q -y update && \
    		yum -q -y upgrade && \
		yum -q -y install wget unzip git java-1.8.0-openjdk-devel

RUN		wget -q https://services.gradle.org/distributions/gradle-2.14-bin.zip -P /tmp && \
		unzip -qq /tmp/gradle-2.14-bin.zip -d /opt

RUN		mkdir /root/.ssh
ADD 		Docker_keypair.key /root/.ssh/id_rsa
RUN		chmod 400 /root/.ssh/id_rsa
RUN		touch /root/.ssh/known_hosts
RUN		chmod 644 /root/.ssh/known_hosts
RUN		ssh-keyscan REPLACE.Git >> /root/.ssh/known_hosts
RUN		git clone REPLACE@SERVER.git $APP_HOME
RUN		cd $APP_HOME && \
		gradle -q build

WORKDIR		$APP_RUN
