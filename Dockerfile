FROM adoptopenjdk/openjdk11:alpine-jre
MAINTAINER <roberto@rhizomik.net>

ENV OPENREFINE_VERSION 3.8.2
ENV RDF_EXTENSION_VERSION 1.5.0
ENV RDFT_EXTENSION_VERSION 2.2.2
ENV OPENREFINE_FILE openrefine-linux-${OPENREFINE_VERSION}.tar.gz
ENV RDF_EXTENSION_FILE rdf-extension-${RDF_EXTENSION_VERSION}.zip
ENV RDTF_EXTENSION_FILE rdf-transform-${RDFT_EXTENSION_VERSION}.zip
ENV OPENREFINE_URL https://github.com/OpenRefine/OpenRefine/releases/download/${OPENREFINE_VERSION}/${OPENREFINE_FILE}
ENV RDF_EXTENSION_URL https://github.com/stkenny/grefine-rdf-extension/releases/download/v${RDF_EXTENSION_VERSION}/${RDF_EXTENSION_FILE}
ENV RDFT_EXTENSION_URL https://github.com/AtesComp/rdf-transform/releases/download/v${RDFT_EXTENSION_VERSION}/${RDTF_EXTENSION_FILE}

WORKDIR /app

RUN set -xe \
    && apk add --no-cache bash curl jq tar unzip \
    && curl -sSL ${OPENREFINE_URL} | tar xz --strip 1 \
    && cd webapp/extensions && mkdir rdf-extension \
    && curl -sSL ${RDF_EXTENSION_URL} -o rdf-extension.zip \
    && unzip -d rdf-extension rdf-extension.zip && rm rdf-extension.zip \
    && curl -sSL ${RDFT_EXTENSION_URL} -o rdf-transform.zip \
    && unzip rdf-transform.zip && rm rdf-transform.zip

VOLUME /data
WORKDIR /data

EXPOSE 3333

ENTRYPOINT ["/app/refine"]
CMD ["-i", "0.0.0.0", "-d", "/data"]
