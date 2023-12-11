# Next Steps

Documenting a roadmap for future features.

## List

- Option to use mounted secret instead of env var
- Watch for updates to secrets and update the k8s secret
- Need some kind of validation on secret names, have to be lowercase, no underscores, etc.
- Create CONTRIBUTING.md and pr template, changelog
- Helm chart publishing
- Could probably mount the hooks to make testing faster?
- The operator should be able to delete secrets it has created, but not secrets it doesn't
    - Maybe an annotation could do this.
- Add linting for helm chart?, shell scripts
