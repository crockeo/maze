module Utils where

concatWith :: a -> [[a]] -> [a]
concatWith l = foldl1 (\a b -> a ++ [l] ++ b)
