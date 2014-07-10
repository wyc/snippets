#include <stdio.h>
#include <stdlib.h>

void trap()
{
        puts("it's a trap!");
        exit(EXIT_FAILURE);
}

void load()
{
        int i = 0xdeadbeef;
        int j = 0xc0ffee;
        long int k = 0xba173d;
        long int l = 0xBADCAFE;
        i = i;
        j = j;
        k = k;
        l = l;
}

int main()
{
        long int x = 0xBADF00D;
        load();
        puts("safely back to main!");
        return x;
}

