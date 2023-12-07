# Next Steps

Documenting a roadmap for future features.

## List

- Option to use mounted secret instead of env var
- Watch for updates to secrets and update the k8s secret
- Either have a helm chart or use kustomize to make deployment easier for users
- Right now this puts secrets into the namespace it is deployed to, should be able to provide the namespace as a param
- Need some kind of validation on secret names, have to be lowercase, no underscores, etc.
- Need to set up a better way to develop
