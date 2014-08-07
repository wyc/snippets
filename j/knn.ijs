NB. naive k-nearest neighbors in J

dist =: [:%:[:|[:+/(*:@:-)    NB. dyad takes two vectors, returns euclidean distance
enum =: ,:i.@#                NB. monad appends row of increasing integers from 0
tsort =: /:@:{~&0{"1]         NB. sorts the tuples by first value

data =: 1 2 3,2 2 3,2 3 3,1 2 3,:2 3 4
query =: 1 2 3
k =: 3

k {."1 tsort enum query&dist"1 data

