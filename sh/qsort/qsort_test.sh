#!/bin/sh

SCRIPT="./qsort.sh"
TESTS=20

trimws()
{
    echo $* | sed 's/^ *//g' | sed 's/ *$//g'
}

qsort_test()
{
    [ -e "$SCRIPT" ] || (echo "$0: no script file '$SCRIPT'" 1>&2; exit -1)
    for i in `seq $TESTS`; do
        local U=""
        for j in `seq $(($RANDOM%100+1))`; do
            U="$U $(($RANDOM%1000+1))"
        done
        RS=`printf "%s\n" $U | sort -n`
        RS=`trimws $RS`
        TS=`$SCRIPT $U`
        TS=`trimws $TS`
        [ "$RS" = "$TS" ] || \
            (echo "$0: test failed; expected '$RS', got '$TS'" 1>&2; exit -1)
    done
    echo "$TESTS rounds of randomly generated tests passed."
}

qsort_test

