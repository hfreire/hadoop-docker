FROM hfreire/hadoop:2.7.2

ENV FLUME_VERSION 1.7.0
ENV FLUME_HOME /opt/flume-$FLUME_VERSION

RUN apt-get update && apt-get install -q -y --no-install-recommends wget && \
  mkdir $FLUME_HOME && \
  wget -qO- http://archive.apache.org/dist/flume/$FLUME_VERSION/apache-flume-"$FLUME_VERSION"-bin.tar.gz \
  | tar zxf - -C $FLUME_HOME --strip 1
RUN rm $FLUME_HOME/lib/httpclient-4.2.1.jar && \
  rm $FLUME_HOME/lib/httpcore-4.1.3.jar && \
  rm $FLUME_HOME/lib/joda-time-2.1.jar

WORKDIR $FLUME_HOME
ENV PATH $FLUME_HOME/bin:$PATH

ADD flume-entrypoint.sh /
ADD flume.sh /
ADD lib/ $FLUME_HOME/lib/

RUN chmod a+x /flume-entrypoint.sh && \
  chmod a+x /flume.sh

ENTRYPOINT ["/flume-entrypoint.sh"]
