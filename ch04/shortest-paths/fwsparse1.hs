import Control.Monad.Par
import Data.IntMap (IntMap)
import qualified Data.IntMap.Strict as Map
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
      [ (0, Map.fromList [(1,5), (2,3), (3,8)])
      , (1, Map.fromList [(3,2)])
      , (2, Map.fromList [(3,20)])
      ]

-- 2頂点間に枝が無ければ Nothing を返す
-- 
-- *Main> weight g 0 2
-- Just 3
-- *Main> weight g 1 2
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
-- *Main > shortestPaths [0..3] g
-- fromList [(0,fromList [(1,5),(2,3),(3,7)]),(1,fromList [(3,2)]),(2,fromList [(3,20)])]
shortestPaths :: [Vertex] -> Graph -> Graph
shortestPaths vs g = foldl' update g vs
  where
    -- update g k = Map.mapWithKey shortmap g
    update g k = runPar $ do
                    m <- Map.traverseWithKey (\i jmap -> spawn (return (shortmap i jmap))) g
                    traverse get m
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

{- MEMO
shortmap i jmap :: IntMap Weight
return (shortmap i jmap) :: Par (IntMap Weight)
spawn (return (shortmap i jmap))
  :: Par (IVar (IntMap Weight))
    ---- ------------------------
      t            b

traverse
  :: (Traversable t, Applicative f) => (a -> f b) -> t a -> f (t b)
-}