# h3daemon

## Usage

Download example and create directory for logging (optional).

```
wget https://uk1s3.embassy.ebi.ac.uk/deciphon/minifam.hmm
mkdir logs
```

Run the application

```
./h3daemon minifam.hmm --logdir=logs
```

## Development

### Build

```
podman build -t localhost/h3daemon .
```

### Run

```
wget https://uk1s3.embassy.ebi.ac.uk/deciphon/minifam.hmm
mkdir logs
podman run -p 51371:51371 -v "$PWD/minifam.hmm":/app/data/minifam.hmm -v "$PWD/logs:/app/logs" --rm localhost/h3daemon minifam.hmm
```
