
# beauty-of-haskell

Short code snippets for the beauty of Haskell.

### Applicative functor

```hs
let result = pure (+) <*> Just 3 <*> Just 5
-- ghci> result
-- Just 8
```

```hs
let result = (++) <$> Just "a" <*> Just "b" <*> Just "c"
-- ghci> result
-- Just "abc"
```

```hs
let result = (*) <$> [2,5,10] <*> [8,10,11]
-- ghci> result
-- [16,20,22,40,50,55,80,100,110]
```

```hs
let result = filter (>50) $ (*) <$> [2,5,10] <*> [8,10,11]
-- ghci> result
-- [55,80,100,110]
```

```hs
main = do
  a <- (++) <$> getLine <*> getLine
  putStrLn $ "The two lines: " ++ a
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

-- ghci> numsTree   
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

-- ghci> 8 `hasElem` numsTree   
-- True   
-- ghci> 100 `hasElem` numsTree   
-- False   
-- ghci> 1 `hasElem` numsTree   
-- True   
-- ghci> 10 `hasElem` numsTree   
-- False
```
