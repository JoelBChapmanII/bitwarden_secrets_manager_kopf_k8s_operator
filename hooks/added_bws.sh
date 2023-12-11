#!/usr/bin/env bash

if [[ $1 == "--config" ]] ; then
  cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: bwsm.com/v1
  kind: BitwardenSecret
  executeHookOnEvent: ["Added"]
EOF
else
  SECRET_NAME=$(jq -r '.[] | .object.spec.secretName' $BINDING_CONTEXT_PATH)
  SECRET_VALUE=$(/root/.cargo/bin/bws secret get $(jq -r '.[] | .object.spec.secretUUID' $BINDING_CONTEXT_PATH) | jq -r .value)
  SECRET_NAMESPACE=$(jq -r '.[] | .object.spec.secretNamespace' $BINDING_CONTEXT_PATH)
  kubectl create secret generic -n $SECRET_NAMESPACE "$SECRET_NAME" --from-literal=$SECRET_NAME=$SECRET_VALUE
  unset SECRET_NAME SECRET_VALUE SECRET_NAMESPACE
fi
