map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

let result = map (+3) [1,2,3]
-- > result
-- [4,5,6]

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ [] _ = []
zipWith _ _ [] = []
zipWith f (x:xs) (y:ys) = f x y : zipWith f xs ys

let result = zipWith (\x y -> x + 2y) [1,2,3] [4,5,6]
-- > result
-- [9,12,15]
