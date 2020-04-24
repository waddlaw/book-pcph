module Main (main) where

import Control.Parallel.Strategies hiding (evalList)

main :: IO ()
main = return ()

evalList :: Strategy a -> Strategy [a]
evalList strat [] = return []
evalList strat (x:xs) = do
  x' <- strat x
  xs' <- evalList strat xs
  return (x':xs')

parList :: Strategy a -> Strategy [a]
parList strat = evalList (rparWith strat)