#!/bin/bash

set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /hermes/tmp/pids/server.pid

# Automaticly create db dan run migration when running 'docker-compose up web'
if [[ "$@" == "bundle exec rails server -b 0.0.0.0 -P /tmp/server.pid" ]]; then
    bundle exec rails db:create db:migrate
    # Genereate assets when manifest not exists
    if [ ! -f '/hermes/public/packs/manifest.json' ]; then
        bundle exec rails assets:precompile
    fi
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
