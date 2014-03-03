#!/bin/sh

# search contents
function sc()
{
    find . -type f -exec grep -Hn "$@" {} \;
}

