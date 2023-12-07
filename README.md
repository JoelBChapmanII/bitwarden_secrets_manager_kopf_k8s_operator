# Bitwarden Secrets Manager kopf k8s Operator

The intent of this project is to create an operator that will sync secrets from bitwarden secrets manager to a cluster's secrets.

## Usage

```bash
# Configure reused variables
DOCKER_REPOSITORY=REPLACEME
CONTAINER_NAME=bwsm_k8s_operator
CONTAINER_VERSION=latest

# Build container, replace
docker build . -t $DOCKER_REPOSITORY/$CONTAINER_NAME:$CONTAINER_VERSION

# Push to registry
docker push $DOCKER_REPOSITORY/$CONTAINER_NAME:$CONTAINER_VERSION

# Kubectl apply the shell operator configured for bwsm
##### NOTE!!!!! #####
##### You will need to update the shell-operator.yaml with the container image you pushed #####
##### You will also need to provide the secret token for the service account in the bws_secret.yaml #####
kubectl apply -f ./examples/

# Kubectl apply a test secret
##### NOTE!!!!! #####
##### You will need to replace the definition with a secret's UUID from bitwarden secrets manager
kubectl apply  -f ./test/

# View logs and check the secret was created
kubectl -n shell-operator get pods
kubectl -n shell-operator logs POD_NAME -f
kubectl get secrets
```

## Development

TBD - Currently to test I build and push the container to a on prem server.
