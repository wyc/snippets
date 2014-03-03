#!/bin/sh

qsort()
{
    echo "qsort called with args: $@" 1>&2
    local L=""; local G=""; [ $# -eq 1 ] && echo $1 && return 0
    P=$1; shift; for i in $@; do
        echo "deciding '$i' vs. '$P'" 1>&2
        if [ $i -lt $P ]; then 
            echo "adding $i to L" 1>&2
            L="$L $i"
        else
            echo "adding $i to G" 1>&2
            G="$G $i"
        fi
    done

    if [ $(wc -w<<<$L) -gt 0 ]; then
        echo "L has members: $L" 1>&2
        L=`qsort $L`
    fi
    if [ $(wc -w<<<$G) -gt 0 ]; then
        echo "G has members: $G" 1>&2
        G=`qsort $G`
    fi

    echo "block sorted: $L $P $G" 1>&2
    echo "$L $P $G"
}

qsort $@

