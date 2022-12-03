#!/bin/bash
set -e

rm -f /usr/src/app/tmp/pids/server.pid

echo "rails database configuration..."
bundle exec rails db:prepare

exec "$@"
