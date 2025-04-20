composer() {
  docker run --rm -it \
    --volume "$PWD:/app" \
    --volume "${COMPOSER_HOME:-$HOME/.composer}:/tmp" \
    --workdir /app \
    composer "$@"
}

