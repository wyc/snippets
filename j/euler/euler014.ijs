NB. The following iterative sequence is defined for the set of positive integers:
NB. n -> n/2 (n is even)
NB. n -> 3n + 1 (n is odd)

nx =: 2&| { %&2 , +&1@*&3
s =: (,~ nx@{.)^:(1 ~: {.)^:_
{. s"0 ] >:i.1e6

