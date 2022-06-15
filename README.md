# h3daemon

## Usage

Download example and create directory for logging (optional).

```
curl -sOL https://uk1s3.embassy.ebi.ac.uk/deciphon/minifam.hmm
mkdir logs
```

Download and run it.

```
curl -sOL https://app.danilohorta.me/h3daemon
chmod +x h3daemon
./h3daemon start minifam.hmm --logdir=logs
```

Optionally, one can enter a single-line command

```
bash -c "$(curl -fsSL https://app.danilohorta.me/h3daemon)" -s start minifam.hmm --yes
```
