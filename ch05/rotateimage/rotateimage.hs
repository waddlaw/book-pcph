{-# LANGUAGE FlexibleContexts, BangPatterns, LambdaCase #-}

import Data.Array.Repa
import Data.Array.Repa.IO.DevIL
import System.Environment
import Data.Array.Repa.Repr.ForeignPtr
import Data.Word

-- <<main
main :: IO ()
main = do
    [n, f1,f2] <- getArgs
    runIL $ do
      readImage f1 >>= \case -- <1>
        RGB v -> do
          rotated <- computeP $ rotate (read n) v :: IL (Array F DIM3 Word8) -- <2>
          writeImage f2 (RGB rotated)                                        -- <3>
        _ -> error "ERROR"
-- >>

-- <<rotate
rotate :: Double -> Array F DIM3 Word8 -> Array D DIM3 Word8
rotate deg g = fromFunction (Z :. y :. x :. k) f      -- <1>
    where
        sh@(Z :. y :. x :. k)   = extent g

        !theta = pi/180 * deg                         -- <2>

        !st = sin theta                               -- <3>
        !ct = cos theta

        !cy = fromIntegral y / 2 :: Double            -- <4>
        !cx = fromIntegral x / 2 :: Double

        f (Z :. i :. j :. k)                          -- <5>
          | inShape sh old = g ! old                  -- <6>
          | otherwise      = 0                        -- <7>
          where
            fi = fromIntegral i - cy                  -- <8>
            fj = fromIntegral j - cx

            i' = round (st * fj + ct * fi + cy)       -- <9>
            j' = round (ct * fj - st * fi + cx)

            old = Z :. i' :. j' :. k                  -- <10>
-- >>

