#!/bin/bash

usage() {
  echo "Usage: $0 [build|run]"
  exit 1
}

if [ $# -ne 1 ]; then
  usage
fi

set -a; source .env; set +a

case "$1" in
  build)
    docker build -f Dockerfile -t "$DOCKER_IMAGE":dev .
    docker push "$DOCKER_IMAGE":dev
    ;;
  run)
    docker run --rm -it \
      -v sqlite:/app/sqlite \
      -v "${IPFS_PATH}":/app/.ipfs \
      -p 4000:4000 \
      -p 5001:5001 \
      --env-file .env \
      -e DATABASE_PATH=/app/sqlite/pinkie-dev.db \
      "$DOCKER_IMAGE":dev
    ;;
  *)
    usage
    ;;
esac
