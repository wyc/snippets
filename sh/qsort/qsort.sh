#!/bin/sh

# qsort N1 [N2] [N3] [N4] ...
qsort()
{
    local L=""; local G=""; [ $# -eq 1 ] && echo $1 && return;
    P=$1; shift; for i in $@; do [ $i -lt $P ] && L="$L $i" || G="$G $i"; done
    [ -z "$L" ] || L=`qsort $L`; [ -z "$G" ] || G=`qsort $G`; echo "$L $P $G"
}

qsort $@

