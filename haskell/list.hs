-- Haskell lists are single-linked

-- |The 'append' function joins two lists
-- >>> append [1,2,3] [4,5,6]
-- [1,2,3,4,5,6]
append = (++)

-- |The 'cons' function prepends an element to a list
-- >>> cons 1 $ cons 2 [3,4,5]
-- [1,2,3,4,5]
cons = (:)

-- |The 'push' function appends an element to a list
-- >>> push 3 [1,2]
-- [1,2,3]
push x y = append y [x]

-- |The 'car' function takes the first element of a list, same as head
-- "Contents of the Address part of Register number"
-- >>> car [1,2,3]
-- 1
car [] = error "Empty list"
car xs = take 1 xs

-- |The 'cdr' function takes all but first elements of a list, same as tail
-- "Contents of the Decrement part of Register number"
-- >>> cdr [1,2,3]
-- [2,3]
cdr [] = error "Empty list"
cdr xs = drop 1 xs

-- |The 'filterOdd' function returns a new list keeping only odd elements
-- >>> filterOdd [1,2,3]
-- [1,3]
filterOdd = filter odd

-- |The 'allOdd' function checks if a list contains odd elements only
-- >>> allOdd [1,3,5]
-- True
allOdd = all odd

-- |The 'anyOdd' function checks whether there exists at least one odd element
-- >>> anyOdd [2,4,6]
-- False
anyOdd = any odd

-- |The 'notNull' function checks whether there exists at least one
-- element in a list
-- >>> notNull [] 
-- False
notNull = not . null

-- |The 'hasZero' function checks to see if 0 is an element in a list
-- >>> hasZero [0,1,2]
-- True
hasZero = elem 0

-- |The 'doubleOdd' function doubles any odd elements in a list
-- >>> doubleOdd [1,2,3]
-- [2,2,6]
doubleOdd = map (\x -> if odd x then x * 2 else x)

-- | The 'resultPairs' function returns a list of pairs: (input, output)
-- >>> resultPairs signum [-10,10,0]
-- [(-10,-1),(10,1),(0,0)]
resultPairs f xs = zip xs $ map f xs

-- | The 'powerList' function returns a list of an input exponentiated by
-- integers from 0..n-1
-- >>> powerList 2 11
-- [1,2,4,8,16,32,64,128,256,512]
powerList x n = map ($ x) [(flip (^)) i | i <- [0..n-1] ]

-- | The 'halves' function returns two halves of a list storing extra elements
-- in the second half
-- >>> halves [1,2,3,4,5]
-- ([1,2],[3,4,5])
halves xs = splitAt (div (length xs) 2) xs

-- | The 'medianOfSorted' function returns the median of a pre-sorted list 
-- >>> medianOfSorted [1,2,3,4]
-- 2.5
medianOfSorted xs
  | odd len = xs !! mid
  | otherwise = (prev + next) / 2
 where
    len = length xs
    mid = len `div` 2
    prev:next:_ = drop (mid - 1) xs

