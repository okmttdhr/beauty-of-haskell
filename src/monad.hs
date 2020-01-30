
liftM :: (Modan m) => (a -> b) -> m a -> m b
liftM f m = m >>= (\x -> return (f x))

let result = liftM (*3) (Just 8)
-- > result
-- Just 24

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

getLine >>= \x -> return (x ++ x) >>= print

action1 >>= (\x1 -> action2 >>= (\x2 -> action3 x1 x2 ))
