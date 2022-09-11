FROM ruby:3.1.0-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential gnupg2 curl less git libpq-dev postgresql-client chromium \
  && apt-get clean

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get update \
  && apt-get install -y nodejs \
  && apt-get clean

RUN gem update --system && gem install bundler

RUN npm install -g yarn

WORKDIR /usr/src/app

COPY . .

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
