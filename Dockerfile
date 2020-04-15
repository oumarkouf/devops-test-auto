FROM devpico-pfc.dev.echonet:8083/bnpp-pf/python:1.6

LABEL maintainer="Oumar KOUFERIDJI"
LABEL description="BNPP-PF - Previs - Automated Tests Report"


# install Oracle client
USER root

ARG HTTP_RESOURCES="http://devpico-pfc.dev.echonet"
ARG LIBAIO_VERSION="libaio-0.3.109-13.el7.x86_64.rpm"
ARG ORACLE_VERSION="oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm"
RUN curl -o ${LIBAIO_VERSION} ${HTTP_RESOURCES}/tools/pico-rpms/${LIBAIO_VERSION} \
    && yum localinstall -y ${LIBAIO_VERSION} \
    && curl -o ${ORACLE_VERSION} ${HTTP_RESOURCES}/tools/pico-rpms/${ORACLE_VERSION} \
    && yum localinstall -y ${ORACLE_VERSION}
RUN echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf \
    && ldconfig \
    && export LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib:$LD_LIBRARY_PATH

# Return to standard execution user
USER 1001
