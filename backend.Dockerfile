FROM --platform=amd64 ruby:3.2.2

ENV APP_NAME myapp

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && curl -fsSL https://deb.nodesource.com/setup_14.x | bash \
    && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    cron \
    default-mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /${APP_NAME}

COPY ./backend/Gemfile ./backend/Gemfile.lock /${APP_NAME}

ARG RUBYGEMS_VERSION=3.4.10
RUN gem update --system ${RUBYGEMS_VERSION} && \
    bundle install

RUN mkdir -p tmp/sockets && \
    mkdir -p tmp/pids

COPY . /${APP_NAME}

COPY ./backend/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]