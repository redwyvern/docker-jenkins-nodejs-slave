![](https://img.shields.io/docker/stars/redwyvern/jenkins-nodejs-slave.svg)
![](https://img.shields.io/docker/pulls/redwyvern/jenkins-nodejs-slave.svg)
![](https://img.shields.io/docker/automated/redwyvern/jenkins-nodejs-slave.svg)
[![](https://images.microbadger.com/badges/image/redwyvern/jenkins-nodejs-slave.svg)](https://microbadger.com/images/redwyvern/jenkins-nodejs-slave "Get your own image badge on microbadger.com")

Redwyvern Jenkins - NodeJs Slave 
================================

This is the Jenkins Docker slave image for NodeJs software.

This slave contains software to build the following type of projects
* NodeJs

Once a container from this image is running it is ready run as a Jenkins slave without further configuration.

Example YAML file:
```
version: '3'

services:
  nodejs-slave:
    image:  docker.artifactory.weedon.org.au/redwyvern/jenkins-nodejs-slave
    container_name: nodejs-slave
    hostname: nodejs-slave
    restart: always
    dns: 192.168.1.50
    networks:
      - dev_nw

networks:
  dev_nw:
```
