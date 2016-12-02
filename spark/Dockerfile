FROM hfreire/hadoop:2.7.2

ENV SPARK_VERSION 2.0.2
ENV SPARK_HADOOP_PROFILE 2.7

ENV MAVEN_URL https://www.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

ENV SPARK_HOME=/opt/spark-$SPARK_VERSION

RUN set -x \
    && apt-get update && apt-get install -y git \
    && cd /tmp && git clone https://github.com/hfreire/spark.git \
    && cd /tmp/spark && git checkout 584354e \
    && git diff 584354e e013422 | git apply \
    && ./dev/make-distribution.sh --tgz --name $SPARK_HADOOP_PROFILE -Phadoop-provided -Phadoop-$SPARK_HADOOP_PROFILE -Pyarn -DskipTests \
    && tar xzf spark-2.0.3-SNAPSHOT-bin-2.7.tgz -C /opt/ \
    && mv /opt/spark-2.0.3-SNAPSHOT-bin-2.7 /opt/spark-$SPARK_VERSION \
    && rm -rf /tmp/spark  \
    && rm -rf /root/.m2 \
    && apt-get --purge -y remove git && apt-get -y autoremove && apt-get clean

WORKDIR $SPARK_HOME
ENV PATH $SPARK_HOME/bin:$PATH

ADD spark-entrypoint.sh /
ADD spark-historyserver.sh /
ADD spark-master.sh /
ADD spark-slave.sh /

RUN chmod a+x \
    /spark-entrypoint.sh \
    /spark-historyserver.sh \
    /spark-master.sh \
    /spark-slave.sh

RUN echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" >> /opt/spark-$SPARK_VERSION/conf/spark-env.sh

ENTRYPOINT ["/spark-entrypoint.sh"]
