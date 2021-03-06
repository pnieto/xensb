#!/bin/bash

export IMAGE=pnietoiglesias/xensb
export NAME=xensb


build(){
    echo "Build $IMAGE"
    docker build -t ${IMAGE} .
}

debug(){
   echo "Debug ${IMAGE}"
   [ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/pnieto_github
   docker run -t -i -v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent -p 5000:5000 ${IMAGE} /bin/bash
}

run(){
   echo "Run ${IMAGE}"
   docker kill ${NAME}
   docker rm ${NAME}
   docker run -t -i --name ${NAME} -p 5000:5000 ${IMAGE}
}

usage(){
    echo "Usage: $0"
    echo "      -b: build image"
    echo "      -d: debug image with bash"
    echo "      -r: run"
    exit 1;
}

while getopts ":bhdr" opt; do
    case $opt in
        b)
            build
            exit 1
            ;;
        r)
            run
            exit 1
            ;;
        d)
            debug
            exit 1
            ;;
        h)
            usage
            exit 1
            ;;
        \?)
            usage
            exit 1
            ;;
    esac
done

usage
