-- Name: Chloe Conneely,  Username: conneech
module Ex01 where
import Data.Char (toUpper) -- needed for Part 1

{- Part 1

Write a function 'raise' that converts a string to uppercase

Function 'toUpper :: Char -> Char' converts a character to uppercase
if it is lowercase. All other characters are unchanged

-}
raise :: [Char] -> [Char]
raise string = [ toUpper x | x <- string]
raise [] = "Empty string!"

{- Part 2

Write a function 'nth' that returns the nth element of a list

-}
nth :: Int -> [a] -> a
nth _ [] = error "Empty!"
--nth n (x:xs) = xs !! (n-1)
nth 1 xs = head xs
nth n (x:xs) = nth (n-1) xs


{- Part 3

write a function commonLen that compares two sequences
and reports the length of the prefix they have in common.

-}
commonLen :: Eq a => [a] -> [a] -> Int
commonLen xs[] = 0
commonLen []xs = 0
commonLen (x:xs) (y:ys) | x == y = 1+commonLen xs ys
commonLen _ _ = 0