{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeApplications #-}
import Data.Array.Repa as Repa

import Data.Functor.Identity 

ex1 :: Array U DIM1 Int
ex1 = fromListUnboxed (Z :.10) [1..10]

arr :: Array U DIM2 Int
arr = fromListUnboxed (Z :. 3 :. 5) [1..15]

ex2 :: Int
ex2 = toIndex @DIM2 (Z :. 3 :.5) (Z:.2:.1)

ex3 :: Int
ex3 = reshape (Z:.5:.3) arr ! (Z:.2:.1 :: DIM2)

ex4 :: DIM2
ex4 = extent arr

ex5 :: Int
ex5 = rank (extent arr)

ex6 :: Int
ex6 = size (extent arr)

arr2 :: Array U DIM1 Int
arr2 = fromListUnboxed (Z:.10) [1..10]

ex7 :: Array U DIM1 Int
ex7 = computeS (Repa.map (+1) arr2)

ex8 :: Array U DIM1 Int
ex8 = computeS (Repa.map (+1) (Repa.map (^2) arr2))

arr3 :: Array D (Z:.Int) Int
arr3 = fromFunction (Z:.10) (\(Z:.i) -> i :: Int)

ex9 :: Int
ex9 = arr3 ! (Z:.5)

ex10 :: Array U DIM1 Int
ex10 = computeS arr3

mymap :: (Shape sh, Source r e) => (e -> a) -> Array r sh e -> Array D sh a
mymap f a = fromFunction (extent a) (\ix -> f (a ! ix))

ex11 :: Array U DIM1 Int
ex11 = computeS (mymap (+1) arr3)

arr4 :: Array D (Z :. Int) Int
arr4 = fromFunction (Z:.5) (\(Z:.i) -> i)

parr :: Array U DIM1 Int
parr = runIdentity $ computeP arr4

arr5 :: Array D (Z :. Int) Int
arr5 = fromFunction (Z:.5) (\ix -> parr ! ix)

ex12 :: Array U DIM1 Int
ex12 = runIdentity $ computeP arr5

ex13 :: IO (Array U DIM1 Int)
ex13 = do
  let arr = fromFunction (Z:.5) (\(Z:.i) -> i)
  parr <- computeP arr :: IO (Array U DIM1 Int)
  let arr2 = fromFunction (Z:.5) (\ix -> parr ! ix)
  computeP arr2

-- 5.4 畳み込みとシェイプ多相
