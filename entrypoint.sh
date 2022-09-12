#!/bin/bash
set -e

rm -f /usr/src/app/tmp/pids/server.pid

echo "bundle install..."
bundle check || bundle install --jobs 4

echo "yarn install..."
yarn install --check-files

echo "rails database configuration..."
bundle exec rails db:prepare

echo "rails compile assets..."
bundle exec rails assets:precompile

exec "$@"
