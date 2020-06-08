import Control.DeepSeq
import qualified Data.List as List
import Data.Map (Map)
import qualified Data.Map as Map

-- 発表を表現する型
newtype Talk = Talk Int
  deriving (Eq, Ord)

instance NFData Talk where
  rnf (Talk x) = x `seq` ()

instance Show Talk where
  show (Talk t) = show t

-- 参加者
data Person = Person
  { name  :: String   -- 名前
  , talks :: [Talk]   -- 見たい発表のリスト
  } deriving (Show)

p, q :: Person
p = Person "P" [Talk 1, Talk 2]
q = Person "Q" [Talk 2, Talk 3]

-- 時間割
-- [ [トラック1, トラック2, トラック3, トラック4] -- 発表枠順1
-- , [トラック1, トラック2, トラック3, トラック4] -- 発表枠順2
-- , [トラック1, トラック2, トラック3, トラック4] -- 発表枠順3
-- ]
type TimeTable = [[Talk]]

timetable
  :: [Person]
  -> [Talk]
  -> Int    -- トラックの数
  -> Int    -- 発表枠順の数
  -> [TimeTable]
timetable people allTalks maxTrack maxSlot = generate 0 0 [] [] allTalks allTalks
  where
    generate :: Int -> Int -> [[Talk]] -> [Talk] -> [Talk] -> [Talk] -> [TimeTable]
    generate slotNo trackNo slots slot slotTalks talks
      | slotNo == maxSlot = [slots]
      | trackNo == maxTrack = generate (slotNo+1) 0 (slot:slots) [] talks talks
      | otherwise = concat
          [ generate slotNo (trackNo+1) slots (t:slot) slotTalks' talks'
          | (t,ts) <- selects slotTalks
          , let clashesWithT = Map.findWithDefault [] t (clashes people)
          , let slotTalks' = filter (`notElem` clashesWithT) ts
          , let talks' = filter (/= t) talks
          ]

-- *Main> selects [1..3]
-- [(1,[2,3]),(2,[1,3]),(3,[2,1])]
selects :: [a] -> [(a,[a])]
selects xs0 = go [] xs0
  where
   go xs [] = []
   go xs (y:ys) = (y,xs++ys) : go (y:xs) ys


-- p = Person "P" [Talk 1, Talk 2]
-- q = Person "Q" [Talk 2, Talk 3]
--
-- *Main> clashes [p]
-- fromList [(1,[2]),(2,[1])]
--
-- *Main> clashes [q]
-- fromList [(2,[3]),(3,[2])]
--
-- *Main> clashes [p,q]
-- fromList [(1,[2]),(2,[3,1]),(3,[2])]
clashes :: [Person] -> Map Talk [Talk]
clashes people = Map.fromListWith List.union
  [ (t, ts) | s <- people, (t,ts) <- selects (talks s) ]

search
  :: (partial -> Maybe solution)
  -> (partial -> [partial])
  -> partial
  -> [solution]
search finished refine emptysoln = generate emptysoln
  where
    generate partial
      | Just soln <- finished partial = [soln]
      | otherwise = concat (map generate (refine partial))