module Main (main) where

import Sudoku
import Control.Exception
import System.Environment
import Data.Maybe
import Control.Parallel.Strategies hiding (parMap)

parMap :: (a -> b) -> [a] -> Eval [b]
parMap f [] = return []
parMap f (a:as) = do
  b <- rpar (f a)
  bs <- parMap f as
  return (b:bs)

main :: IO ()
main = do
  [f] <- getArgs
  file <- readFile f

  let puzzles = lines file
      solutions = runEval (parMap solve puzzles)

  print $ length $ filter isJust solutions