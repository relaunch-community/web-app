#!/bin/bash
set -e

initialize_user_db()
{
  connection_params=()
  connection_params+=("-h" "${1:-postgres}")
  psql ${1:+${connection_params[@]}} --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER relaunch_community WITH CREATEDB LOGIN password 'relaunch_community' SUPERUSER;
    CREATE DATABASE relaunch_community;
    GRANT ALL PRIVILEGES ON DATABASE relaunch_community TO relaunch_community;
EOSQL
}

initialize_user_db "$1" || true
