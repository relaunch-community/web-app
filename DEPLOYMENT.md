# Deployment

## Fly.io

```sh
fly deploy \
  --build-secret RAILS_MASTER_KEY_SECRET="${RAILS_MASTER_KEY_PROD}" \
  --dockerfile Dockerfile.production
```

### Debugging (docker/secrets)

Note: replace `RAILS_MASTER_KEY_PROD` below with your env var.

```sh
BUILDKIT_PROGRESS=plain docker build \
    --no-cache \
    --secret id=RAILS_MASTER_KEY_SECRET,env=RAILS_MASTER_KEY_PROD \
    --build-arg TARGET_RAILS_ENV="production" \
    --build-arg RAILS_MASTER_KEY=$RAILS_MASTER_KEY_PROD \
    -f Dockerfile.production \
    "."
```
