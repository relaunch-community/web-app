# Deployment

## Fly.io

```sh
fly deploy \
  --build-secret RAILS_MASTER_KEY_SECRET="${RAILS_MASTER_KEY_PROD}" \
  --dockerfile Dockerfile.production
```
