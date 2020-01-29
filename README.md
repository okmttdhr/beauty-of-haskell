
# beauty-of-haskell

Short code snippets for the beauty of Haskell.

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
main = do
  a <- (++) <$> getLine <*> getLine
  putStrLn $ "The two lines: " ++ a
```

### Monad

```hs
return :: Monad m => a -> m a

getLine >>= \x -> return (x ++ x) >>= print
```

```hs
liftM :: (Modan m) => (a -> b) -> m a -> m b
liftM f m = m >>= (\x -> return (f x))

-- > liftM (*3) (Just 8)
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

-- > foldM accMoreThan10 0 [8,9,10,11,12]
-- Just 23
```

```hs
action1 >>= (\ x1 -> action2 >>= (\ x2 -> action3 x1 x2 ))
```

### Quick sort

```hs
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
  let smallerOrEqual = [a | a <- xs, a <= x]
      larger = [a | a <- xs, a > x]
  in quicksort smallerOrEqual ++ [x] ++ quicksort larger
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

## Walk the line

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
