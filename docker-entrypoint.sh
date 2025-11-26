#!/bin/bash
set -e

echo "Ensuring database is ready..."
bundle exec rails db:prepare

exec "$@"
