# h3daemon

## Build

```
podman build -t quay.io/microbiome-informatics/h3daemon:latest .
```

## Run

```
mkdir logs
podman run -v "$PWD/minifam.hmm":/app/data/minifam.hmm -v "$PWD/logs:/app/logs" --rm quay.io/microbiome-informatics/h3daemon:latest minifam.hmm
```
