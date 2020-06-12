{-# OPTIONS_GHC -Wall -fno-warn-name-shadowing #-}

module Main ( main, runtest ) where

import System.Environment
import qualified Data.IntMap.Strict as Map
import Data.IntMap.Strict (IntMap)
import System.Random
import Data.List
import SparseGraph

-- -----------------------------------------------------------------------------
-- shortestPaths

-- <<shortestPaths
shortestPaths :: [Vertex] -> Graph -> Graph
shortestPaths vs g = foldl' update g vs            -- <1>
 where
  update g k = Map.mapWithKey shortmap g           -- <2>
   where
     shortmap :: Vertex -> IntMap Weight -> IntMap Weight
     shortmap i jmap = foldr shortest Map.empty vs -- <3>
        where shortest j m =
                case (old,new) of                  -- <6>
                   (Nothing, Nothing) -> m
                   (Nothing, Just w ) -> Map.insert j w m
                   (Just w,  Nothing) -> Map.insert j w m
                   (Just w1, Just w2) -> Map.insert j (min w1 w2) m
                where
                  old = Map.lookup j jmap          -- <4>
                  new = do w1 <- weight g i k      -- <5>
                           w2 <- weight g k j
                           return (w1+w2)
-- >>

-- -----------------------------------------------------------------------------
-- Testing

-- test :: [[Int]]
-- test  = [[  0, 999, 999,  13, 999, 999],
--          [999,   0, 999, 999,   4,   9],
--          [ 11, 999,   0, 999, 999, 999],
--          [999,   3, 999,   0, 999,   7],
--          [ 15,   5, 999,   1,   0, 999],
--          [ 11, 999, 999,  14, 999,   0]]
test :: [[Int]]
test  = [[ 0,   5,   3,  8 ],
         [ 5,   0, 999,  2 ],
         [ 3, 999,   0, 20 ],
         [ 8,   2,  20,  0 ]]

-- correct result:
-- [ [0,  16, 999, 13, 20, 20],
--   [19,  0, 999,  5,  4,  9],
--   [11, 27,   0, 24, 31, 31],
--   [18,  3, 999,  0,  7,  7],
--   [15,  4, 999,  1,  0,  8],
--   [11, 17, 999, 14, 21,  0] ]

-- [ [0,5,3,7],
--   [5,0,8,2],
--   [3,8,0,10],
--   [7,2,10,0]
-- ]

runtest :: [[Int]]
runtest = fromAdjMatrix (toAdjMatrix 3 (shortestPaths [0..3] (mkGraph test)))

main :: IO ()
main = do
  [h,n] <- fmap (fmap read) getArgs
  let g = mkStdGen 9999
  let (mat,vs) = randomGraph g h 100 n
  print (checksum (shortestPaths vs mat))
