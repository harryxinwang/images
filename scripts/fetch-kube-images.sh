#!/usr/bin/env bash
function push-master-images() {
  declare -a images=(kube-apiserver-amd64 kube-controller-manager-amd64 kube-scheduler-amd64)
  IMAGE_VERSION=$1
  for image in ${images[@]}
  do
    docker pull gcr.io/google_containers/${image}:${IMAGE_VERSION}
    docker tag gcr.io/google_containers/${image}:${IMAGE_VERSION} harryxinwang/${image}:${IMAGE_VERSION}
    docker push harryxinwang/${image}:${IMAGE_VERSION}
  done
}

function pull-master-images() {
  declare -a images=(kube-apiserver-amd64 kube-controller-manager-amd64 kube-scheduler-amd64)
  IMAGE_VERSION=$1
  for image in ${images[@]}
  do
    docker pull harryxinwang/${image}:${IMAGE_VERSION}
    docker tag harryxinwang/${image}:${IMAGE_VERSION} gcr.io/google_containers/${image}:${IMAGE_VERSION}
  done
}

function push-etcd-images() {
  declare -a images=(etcd-amd64)
  IMAGE_VERSION=$1
  for image in ${images[@]}
  do
    docker pull gcr.io/google_containers/${image}:${IMAGE_VERSION}
    docker tag gcr.io/google_containers/${image}:${IMAGE_VERSION} harryxinwang/${image}:${IMAGE_VERSION}
    docker push harryxinwang/${image}:${IMAGE_VERSION}
  done
}

function pull-etcd-images() {
  declare -a images=(etcd-amd64)
  IMAGE_VERSION=$1
  for image in ${images[@]}
  do
    docker pull harryxinwang/${image}:${IMAGE_VERSION}
    docker tag harryxinwang/${image}:${IMAGE_VERSION} gcr.io/google_containers/${image}:${IMAGE_VERSION}
  done
}

function push-all-images() {
  push-master-images 1.8.0
  push-etcd-images 3.0.17
}

function pull-all-images() {
  pull-master-images 1.8.0
  pull-etcd-images 3.0.17
}

function usage {
  echo "push"
  echo "pull"
}

SUBCOMMAND=$1
if [ "$SUBCOMMAND" = "push" ]; then
  push-all-images ${@:2}
elif [ "$SUBCOMMAND" = "pull" ]; then
  pull-all-images ${@:2}
else
  usage
fi
