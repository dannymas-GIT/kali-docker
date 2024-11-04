#!/bin/bash

# Stop container
docker-compose down

# Copy config files and restart
docker-compose up -d --force-recreate

# Show logs
docker-compose logs -f 