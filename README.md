# h3daemon

## Build

```
podman build -t localhost/h3daemon:latest .
```

## Run

```
podman run -v "$PWD/minifam.hmm":/app/data/minifam.hmm -it --rm localhost/h3daemon:latest minifam.hmm
```
