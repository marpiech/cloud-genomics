#!/bin/bash
set -e 

function dockerbuildhelp() {
  printf "  \n"
  printf "  dockerbuilder\n"
  printf "  ************\n"
  printf "  \n"
  printf "  Info:\n"
  printf "  -----\n"
  printf "    Author(s):\n"
  printf "      + Marcin Piechota, <piechota@intelliseq.pl>, https://gitlab.com/marpiech\n"
  printf "    Copyright: Copyright 2020 Intelliseq\n"
  printf "    License: All rights reserved\n"
  printf "  \n"
  printf "  Description:\n"
  printf "  ------------\n"
  printf "  \n"
  printf "  Build and push docker images for Dockerfiles in this repository. Pushing can be diabled.\n"
  printf "  \n"
  printf "      -h|--help                      print help\n"
  printf "      -d|--dockerfile                path to dockerfile\n"
  printf "      -q|--quiet                     print 'docker build' and 'docker push' logs\n"
  printf "      -p|--nopush                    do not push docker image(s) to repository\n"
  printf "      -n|--nocache                   do not use cache when building the docker image(s)\n"
  printf "      -c|--chromosome                build separate images for all chromosomes\n"
  printf "      -f|--forcepush                 push image even if exists\n"
  printf "      -k|--context                   set current directory as context\n"
  printf "  \n"
}

export -f dockerbuildhelp

exec 5> /dev/stdout #VERBOSE
export REPOSITORY="marpiech/"
export CHROMOSOME_LIST=("")

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    dockerbuildhelp
    exit 0
    shift # past argument
    ;;
    -d|--dockerfile)
    export TARGET=$(pwd)"/"$2
    shift # past argument
    shift # past value
    ;;
    -q|--quiet)
    exec 5> /dev/null
    shift # past argument
    ;;
    -p|--nopush)
    export NOPUSH=TRUE
    shift # past argument
    ;;
    -n|--nocache)
    export NOCACHE="--no-cache"
    shift # past argument
    ;;
    -c|--chromosome)
    export CHROMOSOME=TRUE
    export CHROMOSOME_LIST="chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX chrY-and-the-rest"
    shift # past argument
    ;;
    -f|--forcepush)
    export FORCEPUSH=TRUE
    shift # past argument
    ;;
    -k|--context)
    export CONTEXT=$2
    shift
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

SOURCE="${BASH_SOURCE[0]}"

function setrepository() {
    REPOSITORY=$(cat $TARGET | grep "ARG REPOSITORY=" | head -1 | sed 's/\r//g' | sed 's/^ARG REPOSITORY[[:space:]]*=[[:space:]]*//')"/"
}
export -f setrepository

function getname() {
    echo $(cat $TARGET | grep "ARG IMAGE_NAME=" | head -1 | sed 's/\r//g' | sed 's/^ARG IMAGE_NAME[[:space:]]*=[[:space:]]*//')
}
export -f getname

function getversion() {
    echo $(cat $TARGET | grep "ARG VERSION=" | head -1 | sed 's/\r//g' | sed 's/^ARG VERSION[[:space:]]*=[[:space:]]*//')
}
export -f getversion

function gettag() {
    echo $REPOSITORY$(getname)":"$(getversion)
}
export -f gettag

function istargetdefined() {
  if [ -z $TARGET ]
  then
    printf "\n  ERROR: no target provided\n"
    dockerbuildhelp
    exit 1
  else
    printf "=== Building $TARGET\n"
  fi
}
export -f istargetdefined

function dockerfileexists() {
  if [ -f "$TARGET" ]
  then
    printf "=== Docker file $TARGET exists\n"
  else
    printf "\n  ERROR: Docker file $TARGET does not exist\n"
    exit 1
  fi
}

function dockertagexists() {
  if $(curl --silent -f -lSL https://hub.docker.com/v2/repositories/$REPOSITORY/$(getname)/tags/$(getversion) 1> /dev/null 2> /dev/null) || ! $FORCEPUSH
  then
    if [ -z $FORCEPUSH ]
    then 
      printf "\n  ERROR: Docker image $(gettag) exists in dockerhub\n"
      exit 1
    else
      printf "\n WARNING: Image exists. Force pushing!\n"
    fi
  else
    printf "=== Docker image $(gettag) does not exist in dockerhub\n"
  fi

}
export -f dockertagexists

function build {

  if [ -z "$CONTEXT" ]; then
    CONTEXT="-f $(realpath --relative-to=$(pwd) $TARGET) ."
  else
    CONTEXT="-f $(realpath --relative-to=$CONTEXT $TARGET) ."
  fi

  if [ -z "$CHROMOSOME" ]; then
    docker build $NOCACHE -t $(gettag) $CONTEXT 1>&5 2>&5
  else
    for CHROM in $CHROMOSOME_LIST; do
      docker build --build-arg CHROMOSOME=$CHROM $NOCACHE -t $(gettag)'-'$CHROM $CONTEXT 1>&5 2>&5
    done
  fi
}; export -f build

function push {
  if [ ! "$NOPUSH" == "TRUE" ]; then
    if [ -z "$CHROMOSOME" ]; then
      printf "PUSHING: $(gettag) ... \n"
      docker push $(gettag $1) 1>&5
    else
      for CHROM in $CHROMOSOME_LIST; do
        printf "PUSHING: $(gettag)-$CHROM... \n"
        docker push $(gettag)'-'$CHROM 1>&5 2>&5
      done
    fi
  fi
}; export -f push

function procede {
  istargetdefined
  setrepository
  sleep 1
  dockerfileexists
  sleep 1
  dockertagexists
  sleep 1
  build
  sleep 1
  push
  sleep 1
  printf "DONE: $(gettag) ... \n"
}

export -f procede

procede
