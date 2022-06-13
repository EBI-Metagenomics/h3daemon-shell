# h3daemon

## Run

```
wget https://uk1s3.embassy.ebi.ac.uk/deciphon/minifam.hmm
mkdir logs
podman run -v "$PWD/minifam.hmm":/app/data/minifam.hmm -v "$PWD/logs:/app/logs" --rm quay.io/microbiome-informatics/h3daemon minifam.hmm
```
