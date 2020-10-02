{- conneech Chloe Conneely -}
module Ex03 where
import Data.List ((\\))

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !

-- Binary Tree
data BT a b
  = Leaf
  | Branch (BT a b) a b (BT a b)
  deriving (Eq, Show)

-- association list
type Assoc a b = [(a,b)]

-- lookup binary (search) tree
lkpBST :: Ord a1 => BT a1 a -> a1 -> Maybe a
lkpBST Leaf _  =  Nothing
lkpBST (Branch left k d right) k'
 | k < k'     =  lkpBST left k'
 | k > k'     =  lkpBST right k'
 | otherwise  =  Just d

-- Coding Part 1 (13 Marks)

-- insert into binary (search) tree
insBST :: Ord a => a -> b -> BT a b -> BT a b
insBST key val Leaf = Branch Leaf key val Leaf
insBST key val (Branch l k v r)
	| k < key = Branch l k v (insBST key val r)
	| k > key = Branch (insBST key val l) k v r
	| k == key = Branch l key val r

-- Coding Part 2 (6 Marks)

-- convert an association list to a binary search tree
assoc2bst :: Ord a => Assoc a b -> BT a b
assoc2bst [] = Leaf
assoc2bst ((key, val):xs) = insBST key val(assoc2bst xs)

-- Coding Part 3 (6 Marks)

-- convert a binary search tree into an (ordered) association list
bst2assoc :: Ord c =>  BT c e -> Assoc c e
bst2assoc Leaf = []
bst2assoc (Branch l k v r) = bst2assoc l ++ [(k,v)] ++ bst2assoc r
