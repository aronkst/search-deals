FROM ruby:3.1.0-bullseye

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential gnupg2 curl wget less git libpq-dev postgresql-client chromium \
  && apt-get clean

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get update && apt-get install -y --no-install-recommends nodejs \
  && apt-get clean

RUN npm install -g yarn

RUN gem update --system && gem install bundler

WORKDIR /usr/src/app

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
