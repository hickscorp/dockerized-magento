FROM debian:latest

RUN set -x && \
    DEPS="openjdk-7-jre" && \
    BUILD_DEPS="wget" && \
    apt-get update && \
    apt-get install -y --no-install-recommends $DEPS && \
    apt-get install -y --no-install-recommends $BUILD_DEPS && \
    wget http://archive.apache.org/dist/lucene/solr/4.9.1/solr-4.9.1.tgz && \
    tar -xvf solr-4.9.1.tgz -C /usr/local && rm solr-4.9.1.tgz && \
    apt-get purge -y $BUILD_DEPS && apt-get autoremove -y --purge && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV SOLRPATH /usr/local/solr-4.9.1/example
COPY conf/* $SOLRPATH/solr/collection1/conf/

EXPOSE 8983
WORKDIR $SOLRPATH
CMD ["/usr/bin/java", "-Xmx1024m", "-DSTOP.PORT=55101", "-DSTOP.KEY=stop-jetty-solr", "-jar", "start.jar"]
