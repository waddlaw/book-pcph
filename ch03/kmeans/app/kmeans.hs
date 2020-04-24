module Main (main) where

import Data.Function
import Data.List
import Text.Printf
import Data.Vector (Vector)
import qualified Data.Vector as Vector
import qualified Data.Vector.Mutable as MVector

import KMeansCore

main :: IO ()
main = pure ()

-- 標本点集合の和
data PointSum = PointSum !Int !Double !Double

addToPointSum :: PointSum -> Point -> PointSum
addToPointSum (PointSum count xs ys) (Point x y)
  = PointSum (count+1) (xs+x) (ys+y)

pointSumToCluster :: Int -> PointSum -> Cluster
pointSumToCluster i (PointSum count xs ys) =
  Cluster
    { clId = i
    , clCent = Point (xs / fromIntegral count) (ys / fromIntegral count)
    }

-- step1
assign :: Int -> [Cluster] -> [Point] -> Vector PointSum
assign nclusters clusters points = Vector.create $ do
  vec <- MVector.replicate nclusters (PointSum 0 0 0)
  let addpoint p = do
        let c = nearest p
            cid = clId c
        ps <- MVector.read vec cid
        MVector.write vec cid $! addToPointSum ps p

  mapM_ addpoint points
  return vec
  where
    nearest :: Point -> Cluster
    nearest p = fst $ minimumBy (compare `on` snd) [ (c, sqDistance (clCent c) p) | c <- clusters ]

-- step2
makeNewClusters :: Vector PointSum -> [Cluster]
makeNewClusters vec =
  [ pointSumToCluster i ps
  | (i,ps@(PointSum count _ _)) <- zip [0..] (Vector.toList vec)
  , count > 0
  ]

step :: Int -> [Cluster] -> [Point] -> [Cluster]
step nclusters clusters = makeNewClusters . assign nclusters clusters

kmeans_seq :: Int -> [Point] -> [Cluster] -> IO [Cluster]
kmeans_seq nclusters points clusters =
  let
    loop :: Int -> [Cluster] -> IO [Cluster]
    loop n clusters | n > tooMany = do
      putStrLn "giving up."
      return clusters
    loop n clusters = do
      printf "iteration %d\n" n
      putStr (unlines (map show clusters))
      let clusters' = step nclusters clusters points
      if clusters' == clusters
        then return clusters
        else loop (n+1) clusters'
  in
  loop 0 clusters

tooMany :: Int
tooMany = 80