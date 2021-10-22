FROM jupyter/all-spark-notebook

ENV HADOOP_HOME /usr/local/hadoop-3.2.2
ENV LD_LIBRARY_PATH=$HADOOP_HOME/lib/native
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV LD_LIBRARY_PATH=$HADOOP_HOME/lib/native 
ENV JUPYTER_ENABLE_LAB=yes

USER root

RUN apt-get -y update && \
    apt-get install --no-install-recommends\
    openjdk-8-jre-headless\
    ca-certificates-java &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz &&\
    tar xzf hadoop-3.2.2.tar.gz -C /usr/local --owner root --group root --no-same-owner &&\
    rm -f hadoop-3.2.2.tar.gz 

WORKDIR /usr/local/spark/conf

RUN cp spark-env.sh.template spark-env.sh &&\
    cp log4j.properties.template log4j.properties
    
USER ${NB_UID}

WORKDIR "${HOME}"
