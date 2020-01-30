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
