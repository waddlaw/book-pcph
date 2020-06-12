module Lib where

import Data.Array.Accelerate as A
import Data.Array.Accelerate.Interpreter as I

ex1 :: Vector Int
ex1 = fromList (Z:.10) [1..10]

ex2 :: Array DIM2 Int
ex2 = fromList (Z:.3:.5) [1..]

arr :: Array DIM2 Int
arr = fromList (Z:.3:.5) [1..]

ex3 :: Int
ex3 = indexArray arr (Z:.2:.1)

ex4 :: Array DIM2 (Int,Int)
ex4 = fromList (Z:.2:.3) (Prelude.zip [1..] [1..])

ex5 :: Array DIM2 Int
ex5 = run $ A.map (+1) (use arr)

ex6 :: Array DIM2 Int
ex6 = run $ A.map (Prelude.^2) (use arr)

ex7 :: Array DIM0 Int
ex7 = run $ unit 3

arr2 :: Array DIM1 Int
arr2 = fromList (Z:.10) [1..10]

ex8 :: Scalar Int
ex8 = run $ unit (use arr2 ! index1 3)

ex9 :: Array DIM2 Int
ex9 = run $ enumFromStepN (index2 3 5) 15 (-1)

ex10 :: Array DIM2 Int
ex10 = run $ generate (index2 3 5) (\ix -> let Z:.y:.x = unlift ix in x+y)

a :: Acc (Array DIM2 Int)
a = enumFromN (index2 2 3) 1

b1 :: Acc (Array DIM2 Int)
b1 = enumFromStepN (index2 2 3) 6 (-1)

ex11 :: Array DIM2 Int
ex11 = run $ A.zipWith (+) a b1

b2 :: Acc (Array DIM2 Int)
b2 = enumFromStepN (index2 3 5) 10 10

ex12 :: Array DIM2 Int
ex12 = run $ A.zipWith (+) a b2