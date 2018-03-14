# Installs Centos 7, OpenJDK 1.8, OverOps Takipi Agent, Sample application

# Installs Centos 7
# Installs OpenJDK 1.8
# Copies and Installs OverOps Takipi Agent (a.k.a. microagent) using rpm. takipi.rpm must be colocated with Dockerfile.
# Copies scala-boom.jar test app.
# Runs scala-boom.jar test app.


FROM centos:7

MAINTAINER George Navarro "http://www.overops.com/"

RUN yum install -y java-1.8.0-openjdk.x86_64
#RUN yum install -y wget

# Must be colocated with the Dockerfile
COPY ./takipi.rpm /tmp/takipi.rpm

ENV TAKIPI_HOME /opt/takipi
ENV TAKIPI_MASTER_HOST <remote collector IP>
ENV TAKIPI_MASTER_PORT 6060

# Takipi installation
RUN yum install -y /tmp/takipi.rpm

# Install test app
# Test app download: location https://s3.amazonaws.com/app-takipi-com/chen/scala-boom.jar -O scala-boom.jar
# Must be colocated with the Dockerfile

COPY ./scala-boom.jar /tmp/scala-boom.jar

CMD java -agentlib:TakipiAgent -Dtakipi.name=snb -jar /tmp/scala-boom.jar
