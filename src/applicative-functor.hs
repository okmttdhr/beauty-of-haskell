
let result = pure (+) <*> Just 3 <*> Just 5
-- > result
-- Just 8

let result = (++) <$> Just "a" <*> Just "b" <*> Just "c"
-- > result
-- Just "abc"

let result = (*) <$> [2,5,10] <*> [8,10,11]
-- > result
-- [16,20,22,40,50,55,80,100,110]

let result = filter (>50) $ (*) <$> [2,5,10] <*> [8,10,11]
-- > result
-- [55,80,100,110]

let result = getZipList $ (+) <$> ZipList [1,2,3] <*> ZipList [100,100..]
-- > result
-- [101,102,103]

main = do
  a <- (++) <$> getLine <*> getLine
  putStrLn $ "The two lines: " ++ a
