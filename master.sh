#!/bin/bash

if [ "$#" != "1" ]; then
    echo "You need to provide a single argument."
    exit 1
fi

HMM_FILE="/app/data/$1"
if ! test -f "$HMM_FILE"; then
    echo "$HMM_FILE does not exist."
    exit 1
fi

/app/bin/hmmpress "$HMM_FILE"
/app/bin/hmmpgmd --master --hmmdb "$HMM_FILE"
