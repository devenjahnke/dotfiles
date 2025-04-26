composer() {
  docker run --rm -it \
    --volume "$PWD:/app" \
    --volume "${COMPOSER_HOME:-$HOME/.composer}:/tmp" \
    --workdir /app \
    composer "$@"
}

helm() {
  docker run --rm -it \
  	--volume "$PWD:/app" \
	--volume "$HOME/.kube:/root/.kube" \
	--volume "$HOME/.helm:/root/.helm" \
	--volume "$HOME/.config/helm:/root/.config/helm" \
	--volume "$HOME/.cache/helm:/root/.cache/helm" \
	--workdir /app \
	alpine/helm "$@"
}
