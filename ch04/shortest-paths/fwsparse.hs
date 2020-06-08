import Data.IntMap (IntMap)
import qualified Data.IntMap.Strict as Map
import qualified Data.IntMap.Lazy as LMap
import qualified Data.IntMap.Strict as SMap
import Data.List

type Vertex = Int
type Weight = Int

-- グラフは本質的にはノードの組から重みへのマップ
--
--   type Graph = Map (Vertex, Vertex) Weight
--
-- 効率のために2層のマップを用いている
type Graph = IntMap (IntMap Weight)

g :: Graph
g = Map.fromList
      [ (1, Map.fromList [(1,0), (2,5), (3,3), (4,8)])
      , (2, Map.fromList [(1,5), (2,0), (3,999), (4,2)])
      , (3, Map.fromList [(1,3), (2,999), (3,0), (4,20)])
      , (4, Map.fromList [(1,8), (2,2), (3,20), (4,0)])
      ]

-- 2頂点間に枝が無ければ Nothing を返す
-- 
-- *Main> weight g 1 3
-- Just 3
--
-- *Main> weight g 2 3
-- Nothing
weight :: Graph -> Vertex -> Vertex -> Maybe Weight
weight g i j = do
  jmap <- Map.lookup i g
  Map.lookup j jmap

-- 頂点のリストとグラフを受け取る (グラフから頂点のリストを取り出すことも可能)
--
-- 引数のグラフは「頂点間の枝の重み」
-- 戻り値のグラフは「頂点間の最短路の長さ」
--
-- *Main> shortestPaths [1..4] g
-- fromList
--   [ (1,fromList [(1,0),(2,5),(3,3),(4,7)]),
--     (2,fromList [(1,5),(2,0),(3,8),(4,2)]),
--     (3,fromList [(1,3),(2,8),(3,0),(4,10)]),
--     (4,fromList [(1,7),(2,2),(3,10),(4,0)])
--   ]
shortestPaths :: [Vertex] -> Graph -> Graph
shortestPaths vs g = foldl' update g vs
  where
    update g k = Map.mapWithKey shortmap g
      where
        shortmap :: Vertex -> IntMap Weight -> IntMap Weight
        shortmap i jmap = foldr shortest Map.empty vs
          where
            shortest j m =
              case (old,new) of
                (Nothing, Nothing) -> m
                (Nothing, Just w ) -> Map.insert j w m
                (Just w,  Nothing) -> Map.insert j w m
                (Just w1, Just w2) -> Map.insert j (min w1 w2) m
              where
                old = Map.lookup j jmap
                new = do
                  w1 <- weight g i k
                  w2 <- weight g k j
                  return (w1+w2)

-- 指数的な再帰呼び出しが必要になるため、このように実装するのは望ましく無い
-- g: グラフ
-- i: 接続元
-- j: 接続先
-- k: 頂点の数
-- shortestPath :: Graph -> Vertex -> Vertex -> Vertex -> Weight
-- shortestPath g i j 0 = weight g i j
-- shortestPath g i j k =
--   min (shortestPath g i j (k-1))
--       (shortestPath g i k (k-1) + shortestPath g k j (k-1))

f1,f2 :: [Int]
f1 = LMap.keys $ LMap.fromList [(0,undefined)]
f2 = SMap.keys $ SMap.fromList [(0,undefined)]

{- MEMO
mapWithKey :: (Key -> a -> b) -> IntMap a -> IntMap b
mapWithKey f (fromList [(k1,v1), (k2,v2)]) == fromList [(k1, f k1 v1), (k2, f k2 v2)]
-}