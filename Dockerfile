FROM ruby:3.1.2-slim

ARG ARCH=amd64

ENV LANG=C.UTF-8
ENV ARCH=${ARCH}

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends curl gnupg gnupg2 wget

RUN wget http://ftp.debian.org/debian/pool/main/r/readline/libreadline7_7.0-5_${ARCH}.deb && \
    dpkg -i libreadline7_7.0-5_${ARCH}.deb && \
    rm -f libreadline7_7.0-5_${ARCH}.deb

RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential \
      libcurl4-openssl-dev libpq-dev ruby-dev libxml2-dev \
      imagemagick libjpeg-dev libpng-dev openssh-client \
      git nodejs postgresql-client-14 && \
    apt-get clean

WORKDIR /app
ARG USER_ID=1000
ARG GROUP_ID=1000

COPY --chown=$USER_ID:$GROUP_ID Gemfile /app/Gemfile
COPY --chown=$USER_ID:$GROUP_ID Gemfile.lock /app/Gemfile.lock
RUN gem install bundler -v 2.3.14 && bundle install

COPY --chown=$USER_ID:$GROUP_ID package.json /hermes/package.json

COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

RUN groupadd -f -r angelico --gid=$GROUP_ID && \
    useradd --create-home -r angelico -g $GROUP_ID --uid=$USER_ID

USER $USER_ID:$GROUP_ID

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-P", "/tmp/server.pid"]
