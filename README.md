
# beauty-of-haskell

Short code snippets for the beauty of Haskell.

### List

```hs
let result = 1:2:3:4:[]
-- > result
-- [1,2,3,4]
```

```hs
let result = [1,2,3,4] ++ [5,6,7,8]
-- > result
-- [1,2,3,4,5,6,7,8]
```

```hs
let result = take 5 [13,26..]
-- > result
-- [13,26,39,52,65]
```

```hs
let rightTriangles = [ (a,b,c) | c <- [1..10], a <- [1..c], b <- [1..a], a^2 + b^2 == c^2, a+b+c == 24]
-- > rightTriangles
-- [(8,6,10)]
```

```hs
maximum :: (Ord a) => [a] -> a
maximum [] = error "empty list"
maximum [x] = x
maximum (x:xs) = max x (maximum xs)

let result = maximum [1,2,3]
-- > result
-- 3
```

```hs
reverse :: a -> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]

let result = reverse [1,2,3]
-- > result
-- [3,2,1]
```

```hs
zip :: [a] -> [b] -> [(a,b)]
zip _ [] = []
zip [] _ = []
zip (x:xs) (y:ys) = (x,y) : zip xs ys

let result = zip [1,2,3] [1,2,3]
-- > result
-- [(1,1),(2,2),(3,3)]
```

```hs
repeat' :: a -> [a]
repeat' x = x : repeat' x
```

### Higher order function

```hs
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

let result = map (+3) [1,2,3]
-- > result
-- [4,5,6]
```

```hs
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ [] _ = []
zipWith _ _ [] = []
zipWith f (x:xs) (y:ys) = f x y : zipWith f xs ys

let result = zipWith (\x y -> x + 2y) [1,2,3] [4,5,6]
-- > result
-- [9,12,15]
```

### Function composition

```hs
fn = ceiling . negate . tan . cos . max 50
```

```hs
replicate 2 . product . map (*3) $ zipWith max [1,2] [4,5]
```

```hs
oddSquareSum :: Integer
oddSquareSum = sum . takeWhile (<10000) . filter odd $ map (^2) [1..]
```

### Applicative functor

```hs
let result = pure (+) <*> Just 3 <*> Just 5
-- > result
-- Just 8
```

```hs
let result = (++) <$> Just "a" <*> Just "b" <*> Just "c"
-- > result
-- Just "abc"
```

```hs
let result = (*) <$> [2,5,10] <*> [8,10,11]
-- > result
-- [16,20,22,40,50,55,80,100,110]
```

```hs
let result = filter (>50) $ (*) <$> [2,5,10] <*> [8,10,11]
-- > result
-- [55,80,100,110]
```

```hs
let result = getZipList $ (+) <$> ZipList [1,2,3] <*> ZipList [100,100..]
-- > result
-- [101,102,103]
```

```hs
main = do
  a <- (++) <$> getLine <*> getLine
  putStrLn $ "The two lines: " ++ a
```

### Monad

```hs
liftM :: (Modan m) => (a -> b) -> m a -> m b
liftM f m = m >>= (\x -> return (f x))

let result = liftM (*3) (Just 8)
-- > result
-- Just 24
```

```hs
foldM :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m a
foldM f a []     = return a
foldM f a (x:xs) = f a x >>= \ y -> foldM f y xs

accMoreThan10 :: Int -> Int -> Maybe Int
accMoreThan10 acc x
  | x > 10    = Nothing
  | otherwise = Just (acc + x)

let result = foldM accMoreThan10 0 [8,9,10,11,12]
-- > result
-- Just 23
```

```hs
getLine >>= \x -> return (x ++ x) >>= print
```

```hs
action1 >>= (\x1 -> action2 >>= (\x2 -> action3 x1 x2 ))
```

### Quick sort

```hs
quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = 
  let smallerOrEqual = filter (<= x) xs
      larger         = filter (> x) xs
  in quickSort smallerOrEqual ++ [x] ++ quickSort larger

-- > quickSort [10,2,5,3,1,6,7,4,2,3,4,8,9]
-- [1,2,2,3,3,4,4,5,6,7,8,9,10]

-- > quickSort "lorem ipsum dolor sit amet, consectetur adipiscing elit"
-- "       ,aacccddeeeeegiiiiiilllmmmnnoooopprrrsssstttttuu"
```

### Merge sort

```hs
merge :: (Ord a) => [a] -> [a] -> [a]
merge [] xs = xs
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y    = x:merge xs (y:ys)
  | otherwise = y:merge (x:xs) ys

half :: [a] -> ([a], [a])
half xs = (take n xs, drop n xs)
  where n = length xs `div` 2 

mergeSort :: (Ord a) => [a] -> [a]
mergeSort xs 
  | length xs < 2 = xs
  | otherwise     = merge (mergeSort ls) (mergeSort rs)
  where (ls, rs) = half xs

-- > mergeSort [1,20,3,5,6,6,7,34,1,90]
-- [1,1,3,5,6,6,7,20,34,90]

-- > mergeSort "lorem ipsum dolor sit amet, consectetur adipiscing elit"
-- "       ,aacccddeeeeegiiiiiilllmmmnnoooopprrrsssstttttuu"
```

### Binary search tree

```hs
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

singleton :: a -> Tree a   
singleton x = Node x EmptyTree EmptyTree   
  
treeInsert :: (Ord a) => a -> Tree a -> Tree a   
treeInsert x EmptyTree = singleton x   
treeInsert x (Node a left right)    
    | x == a = Node x left right   
    | x < a  = Node a (treeInsert x left) right   
    | x > a  = Node a left (treeInsert x right)

let nums = [8,6,4,1,7,3,5]   
let numsTree = foldr treeInsert EmptyTree nums   

-- > numsTree   
-- Node 5 
--     (Node 3 
--         (Node 1 EmptyTree EmptyTree) 
--         (Node 4 EmptyTree EmptyTree)
--     ) 
--     (Node 7 
--         (Node 6 EmptyTree EmptyTree) 
--         (Node 8 EmptyTree EmptyTree)
--     )

hasElem :: (Ord a) => a -> Tree a -> Bool   
hasElem x EmptyTree = False   
hasElem x (Node a left right)   
    | x == a = True   
    | x < a  = hasElem x left   
    | x > a  = hasElem x right

-- > 8 `hasElem` numsTree   
-- True   
-- > 100 `hasElem` numsTree   
-- False   
-- > 1 `hasElem` numsTree   
-- True   
-- > 10 `hasElem` numsTree   
-- False
```

### Walk the line

from [Learn You a Haskell for Great Good!](http://learnyouahaskell.com/a-fistful-of-monads)

```hs
type Birds = Int
type Pole = (Birds, Birds)

landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right)
    | abs ((left + n) - right) < 4 = Just (left + n, right)
    | otherwise                    = Nothing

landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right)
    | abs (left - (right + n)) < 4 = Just (left, right + n)
    | otherwise                    = Nothing

let result = return (0, 0) >>= landRight 2 >>= landLeft 2 >>= landRight 2
-- > result
-- Just (2,4)

let result =  return (0, 0) >>= landLeft 1 >>= landRight 4 >>= landLeft (-1) >>= landRight (-2)
-- > result
-- Nothing
```
