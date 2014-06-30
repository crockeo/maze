module Utils where

concatWith :: a -> [[a]] -> [a]
concatWith l = foldl1 (\a b -> a ++ [l] ++ b)

replace :: a -> [a] -> Int -> [a]
replace val list n =
  replace' val list n 0
  where replace' :: a -> [a] -> Int -> Int -> [a]
        replace' val []     n c = []
        replace' val (x:xs) n c
          | n == c    = val : xs
          | otherwise = x   : replace' val xs n (c + 1)

replace2D :: a -> [[a]] -> Int -> Int -> [[a]]
replace2D val list row col =
  replace (replace val (list !! row) col) list row
