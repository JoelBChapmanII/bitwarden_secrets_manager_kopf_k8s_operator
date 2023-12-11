# Bitwarden Secrets Manager Operator

The intent of this project is to create an operator that will sync secrets from bitwarden secrets manager to a cluster's secrets.

## Usage & Installation

### Prerequisites

#### Required Packages

The deployment mechanism used for project is helm. [Helm will need to be installed](https://helm.sh/docs/intro/install/).

#### Bitwarden Secrets Manager Secret Deployment

It is assumed that you have a secret that is usable by the bitwarden secrets manager CLI
to authenticate to the bitwarden secrets manager service. Instruction on how to create this secret
can be found [here](https://bitwarden.com/help/access-tokens/).

Here is an example manifest of the secret using the default values within the helm chart.

```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: bwsm-sa-token
  namespace: MyNamespace
stringData:
  .secretAccessToken: MyVeryLongAndSecureSecret
```

As with any secret please be careful and judicious on where you store this.

You may deploy this secret prior to the helm installation, or you can apply it after the helm installation.

### Installation

```bash
helm upgrade MyRelease ./charts/bitwarden_secrets_manager_operator/ \
-f /path/to/values.yaml --namespace MyNamespace \
--create-namespace --install
```

### Clean Up

```bash
helm delete MyRelease
```

## Development

### Prerequisites

[Kind](https://github.com/kubernetes-sigs/kind) is required for development of this operator, see [installation instructions](https://kind.sigs.k8s.io/docs/user/quick-start/#installation).

### Instructions

```bash
# Create the kind cluster
kind create cluster

# Verify Context
kubectl config current-context
> kind-kind

# Build the docker container for local development
docker build . -t bwsm:development

# Load the image into kind
kind load docker-image bwsm:development

# Create the namespace and bitwarden secrets manager secret
kubectl create ns bwsm
kubectl apply -f /path/to/bwsm_token.yaml # Example in examples/bws_token.yaml

# Deploy the helm chart
helm upgrade bwsm ./charts/bitwarden_secrets_manager_operator/ \
--namespace bwsm -f ./development/values.yaml \
--create-namespace --install

# Apply a test bitwarden secret object
kubectl apply -f /path/to/bwsm_secret_resource.yaml # Example in examples/bws_test_resource.yaml

# Delete the kind cluster
kind delete cluster
```

### Commands for Easier Troubleshooting
```bash
# Follow the bwsm pod logs
kubectl logs -n bwsm -f $(kubectl get pods -n bwsm -o json | jq -r '.items[0].metadata.name')
```

## Frameworks

These are the "frameworks" or projects that are utilized to make bitwarden secrets manager to function.

- https://github.com/flant/shell-operator
- https://github.com/helm/helm/
- https://github.com/bitwarden/sdk
- https://github.com/kubernetes-sigs/kind

## Disclaimer

This project is in no way officially affiliated with the company Bitwarden. This is an
FOSS project leveraging bitwarden's secrets manager.
