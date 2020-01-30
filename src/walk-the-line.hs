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
