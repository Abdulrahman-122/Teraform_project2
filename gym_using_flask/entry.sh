#!/bin/bash
echo "sleeping 10 s until the database boots"
sleep 10

if [ ! -d "migrations" ]; then
  echo "Initializing database migrations..."
  flask db init
  flask db migrate -m "Initial schema"
fi

echo "Waiting for database availability..."
until flask db upgrade; do
  echo "Database not ready yet, sleeping 10s"
  sleep 10
done

echo "Starting Flask..."
exec python run.py
