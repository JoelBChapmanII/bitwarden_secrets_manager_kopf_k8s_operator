# Bitwarden Secrets Manager kopf k8s Operator

The intent of this project is to create an operator that will sync secrets from bitwarden secrets manager to a cluster's secrets.

## Development

```bash
docker build . -t bwsm_k8s_operator:development
docker run -it -v /Users/joelchapman/.kube:/root/.kube bwsm_k8s_operator:development kopf run bws_operator.py --verbose
```
