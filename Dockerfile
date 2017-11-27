FROM docker.artifactory.weedon.org.au/redwyvern/nodejs-devenv-base
MAINTAINER Nick Weedon <nick@weedon.org.au>

ARG GIT_USER=Jenkins
ARG GIT_EMAIL=jenkins@weedon.org.au

# Set user jenkins to the image
RUN useradd -m -d /home/jenkins -s /bin/bash jenkins

COPY authorized_keys /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins.jenkins /home/jenkins/.ssh

USER jenkins

RUN git config --global user.name "${GIT_USER}" && \
    git config --global user.email "${GIT_EMAIL}"

USER root

COPY ./usr /usr

# Install Oracle Java 8 (Java is required for Jenkins slave)
RUN \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y oracle-java8-installer --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Standard SSH port
EXPOSE 22 8080

# Default command
CMD ["/usr/sbin/sshd", "-D"]

