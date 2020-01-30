
let result = 1:2:3:4:[]
-- > result
-- [1,2,3,4]

let result = [1,2,3,4] ++ [5,6,7,8]
-- > result
-- [1,2,3,4,5,6,7,8]

let result = take 5 [13,26..]
-- > result
-- [13,26,39,52,65]

let rightTriangles = [ (a,b,c) | c <- [1..10], a <- [1..c], b <- [1..a], a^2 + b^2 == c^2, a+b+c == 24]
-- > rightTriangles
-- [(8,6,10)]

maximum :: (Ord a) => [a] -> a
maximum [] = error "empty list"
maximum [x] = x
maximum (x:xs) = max x (maximum xs)

let result = maximum [1,2,3]
-- > result
-- 3

reverse :: a -> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]

let result = reverse [1,2,3]
-- > result
-- [3,2,1]

zip :: [a] -> [b] -> [(a,b)]
zip _ [] = []
zip [] _ = []
zip (x:xs) (y:ys) = (x,y) : zip xs ys

let result = zip [1,2,3] [1,2,3]
-- > result
-- [(1,1),(2,2),(3,3)]

repeat' :: a -> [a]
repeat' x = x : repeat' x
