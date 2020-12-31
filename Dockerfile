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
    add-apt-repository ppa:openjdk-r/ppa -y && \
    apt-get clean && apt-get update && apt-get install -y --no-install-recommends openjdk-11-jdk && \
    apt-get -q autoremove && \
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# Standard SSH port
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]

