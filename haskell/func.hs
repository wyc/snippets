f :: Num a => a -> a -> a
f x y = x*x + y*y

g :: Num a => a -> a
g = \y -> 3*3 + y*y

x :: Int
x = 3
y :: Int
y = 2


main = do
     print(f x y)
     print(g y)
