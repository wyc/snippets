import Data.List(foldl')

evenSum :: Integral a => [a] -> a
evenSum = (foldl' (+) 0) . (filter even)

