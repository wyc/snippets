NB. naive k-nearest neighbors in J

dist =: [:%:[:|[:+/(*:@:-)    NB. dyad takes two vectors, returns euclidean distance

data =: 1 2 3,2 2 3,2 3 3,1 2 3,:2 3 4
query =: 1 2 3
k =: 3

k {."1 /:"1 query&dist"1 data

