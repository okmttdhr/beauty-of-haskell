fn = ceiling . negate . tan . cos . max 50

replicate 2 . product . map (*3) $ zipWith max [1,2] [4,5]

oddSquareSum :: Integer
oddSquareSum = sum . takeWhile (<10000) . filter odd $ map (^2) [1..]
