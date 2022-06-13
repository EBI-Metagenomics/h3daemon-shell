# h3daemon

## Build

```
podman build -t localhost/h3daemon:latest .
```

## Run

```
mkdir logs
podman run -v "$PWD/minifam.hmm":/app/data/minifam.hmm -v "$PWD/logs:/app/logs" --rm localhost/h3daemon:latest minifam.hmm
```
