#!/bin/bash

# az aks get-credentials -g rg-lab-$INFRA_NAME -n rg-$ENVIRONMENT-cluster-$CLUSTER_NAME --admin -f ~/.kube/aks-cluster-$CLUSTER_NAME

ENV=""
CLUSTERS=()
MODULE_PATH=""

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "Bootstrap kubernetes with flux"
      echo " "
      echo "sh flux-bootstrap.sh [options]"
      echo " "
      echo "options:"
      echo "-h, --help                                show brief help"
      echo "-e, --environment=dev                     specify an action to use"
      echo "-c, --cluster-name='aks-demo'             specify a directory to store output in"
      echo "-m, --module-path='./flux-bootstrap'      specify the terraform module path for the flux bootstrap"
      echo "\n -------------- Examples --------------\n"
      echo "sh flux-bootstrap.sh -e dev -c cluster-a -c cluster-b --module-path ./flux-bootstrap \n"
      exit 0
      ;;
    -i|--infra-name)
      shift
        INFRA_NAME=$1
      shift
      ;;
    -e|--environment)
      shift
        ENV=$1
      shift
      ;;
    -c|--cluster-name)
      shift
      CLUSTERS+=("$1")
      shift
      ;;
    -m|--module-path)
      shift
        MODULE_PATH=$1
      shift
      ;;
    *)
      break
      ;;
  esac
done

function azCheck() {
  echo ">>> Checking azure account"
  az account show > /dev/null

  if [ $? -eq 0 ]; then
    echo OK
  else
    echo "`az account show` returned an error, maybe you need to run `az login` first"
    exit 1
  fi
}

function getKubeConfig() {
  c=$1

  echo ">> Fetching kubeconfig for cluster $c"
  az aks get-credentials -g rg-$ENV-cluster-$c -n k8s-$ENV-$c --admin -f /tmp/aks-cluster-$c --overwrite-existing
}

function terraformInit() {
  echo ">> Initializing terraform"
  terraform init $MODULE_PATH
}

function runTerraform() {
  c=$1

  echo ">> terraform plan for cluster $c"
  terraform plan -var kube_config_path="/tmp/aks-cluster-$c" $MODULE_PATH
}

function bootstrap() {
  azCheck
  terraformInit

  for c in "${CLUSTERS[@]}"
  do
    getKubeConfig $c
    runTerraform $c
  done
}

bootstrap