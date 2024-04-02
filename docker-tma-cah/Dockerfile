# Dockerfile for `tma-cah` service of CustomCAHDocker.

FROM davidcaste/alpine-tomcat:jdk8tomcat7

LABEL xram.tma.cah="tma-cah"

## MAVEN ##
ENV MAVEN_VERSION 3.9.6
ENV USER_HOME_DIR /root
ENV SHA 6eedd2cae3626d6ad3a5c9ee324bd265853d64297f07f033430755bd0e0c3a4b
ENV BASE_URL https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

RUN apk add --no-cache curl tar procps \
 && mkdir -p /usr/share/maven/ref \
 && curl -fsSL -o /tmp/apache-maven.tar.gz "${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz" \
 && echo "${SHA} /tmp/apache-maven.tar.gz" | sha256sum -c - || true \
 && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
 && rm -f /tmp/apache-maven.tar.gz \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

## PYX ##
# Add script files to `/`
ADD scripts/default.sh scripts/overrides.sh /
ADD docker-tma-cah/tma-cah.sh /

ENV GIT_BRANCH master

RUN apk add dos2unix git --no-cache --repository http://dl-3.alpinelinux.org/alpine/v3.9/community/ --allow-untrusted \
  && dos2unix /default.sh /overrides.sh /tma-cah.sh \
  && git clone -b $GIT_BRANCH https://github.com/xram64/CustomCAH.git /project \
  && apk del dos2unix git \
  && chmod +x /default.sh /overrides.sh /tma-cah.sh \
  && mkdir /overrides

# Add Docker settings file to `/usr/share/maven/ref/`
ADD ./overrides/settings-docker.xml /usr/share/maven/ref/

VOLUME [ "/overrides" ]

# Move into the CustomCAH repo files downloaded to `/project`.
WORKDIR /project

# Run the build script.
CMD [ "/tma-cah.sh" ]