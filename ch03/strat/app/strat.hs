module Main (main) where

import Control.Parallel.Strategies hiding (parPair)
import Control.DeepSeq

main :: IO ()
main = print ((fib 35, fib 36) `using` parPair rpar rpar)

-- parPair :: Strategy (a,b)
-- parPair (a,b) = do
--   a' <- rpar a
--   b' <- rpar b
--   return (a', b')

-- parPair :: Strategy (a,b)
-- parPair = evalPair rpar rpar

parPair :: Strategy a -> Strategy b -> Strategy (a,b)
parPair sa sb = evalPair (rparWith sa) (rparWith sb)

evalPair :: Strategy a -> Strategy b -> Strategy (a,b)
evalPair sa sb (a,b) = do
  a' <- sa a
  b' <- sb b
  return (a',b')

rdeepseq :: NFData a => Strategy a
rdeepseq x = rseq (force x)

r0 :: Strategy a
r0 x = return x

fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)