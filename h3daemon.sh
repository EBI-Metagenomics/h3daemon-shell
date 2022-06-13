#!/bin/bash

function usage() {
    echo "h3daemon HMMFILE [--logdir=LOGDIR]"
}

if [ $# == 0 ]; then
    usage
    exit 1
fi

# https://github.com/morgant/realpath
function realpath() {
    local success=true
    local path="$1"

    # make sure the string isn't empty as that implies something in further logic
    if [ -z "$path" ]; then
        success=false
    else
        # start with the file name (sans the trailing slash)
        path="${path%/}"

        # if we stripped off the trailing slash and were left with nothing, that means we're in the root directory
        if [ -z "$path" ]; then
            path="/"
        fi

        # get the basename of the file (ignoring '.' & '..', because they're really part of the path)
        local file_basename="${path##*/}"
        if [[ ("$file_basename" = ".") || ("$file_basename" = "..") ]]; then
            file_basename=""
        fi

        # extracts the directory component of the full path, if it's empty then assume '.' (the current working directory)
        local directory="${path%"$file_basename"}"
        if [ -z "$directory" ]; then
            directory='.'
        fi

        # attempt to change to the directory
        if ! cd "$directory" &>/dev/null; then
            success=false
        fi

        if $success; then
            # does the filename exist?
            if [[ (-n "$file_basename") && (! -e "$file_basename") ]]; then
                success=false
            fi

            # get the absolute path of the current directory & change back to previous directory
            local abs_path
            abs_path="$(pwd -P)"
            cd "-" &>/dev/null || exit 1

            # Append base filename to absolute path
            if [ "${abs_path}" = "/" ]; then
                abs_path="${abs_path}${file_basename}"
            else
                abs_path="${abs_path}/${file_basename}"
            fi

            # Remove last slash if not root directory
            if [ ${#abs_path} -ge 2 ]; then
                if [ "${abs_path: -1}" == "/" ]; then
                    echo "${abs_path::${#abs_path}-1}"
                else
                    echo "${abs_path}"
                fi
            else
                # output the absolute path
                echo "$abs_path"
            fi
        fi
    fi

    $success
}

HMMFILE=$(realpath "$1")
shift 1

for i in "$@"; do
    case $i in
        --logdir=*)
            LOGDIR=$(realpath "${i#*=}")
            shift
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        -*)
            usage
            exit 1
            ;;
        *) ;;

    esac
done

if [ $# != 0 ]; then
    usage
    exit 1
fi

if [ ! -f "$HMMFILE" ]; then
    echo >&2 "$HMMFILE file not found!"
    exit 1
fi

if [ -n "$LOGDIR" ]; then
    if [ ! -d "$LOGDIR" ]; then
        echo >&2 "$LOGDIR directory not found!"
        exit 1
    fi
fi

cmd="podman run -v $HMMFILE:/app/data/"$(basename "$HMMFILE")

if [ -n "$LOGDIR" ]; then
    cmd="$cmd -v $LOGDIR:/app/logs"
fi

image=quay.io/microbiome-informatics/h3daemon
cmd="$cmd --rm $image $(basename "$HMMFILE")"

# echo "$cmd"
$cmd
