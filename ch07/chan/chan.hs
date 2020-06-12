import Control.Concurrent hiding (Chan, newChan, readChan, writeChan, dupChan)

-- <<Stream
type Stream a = MVar (Item a)
data Item a   = Item a (Stream a)
-- >>

-- <<Chan
data Chan a
 = Chan (MVar (Stream a))
        (MVar (Stream a))
-- >>

-- <<newChan
newChan :: IO (Chan a)
newChan = do
  hole  <- newEmptyMVar
  readVar  <- newMVar hole
  writeVar <- newMVar hole
  return (Chan readVar writeVar)
-- >>

-- <<writeChan
writeChan :: Chan a -> a -> IO ()
writeChan (Chan _ writeVar) val = do
  newHole <- newEmptyMVar
  oldHole <- takeMVar writeVar
  putMVar oldHole (Item val newHole)
  putMVar writeVar newHole
-- >>

-- <<readChan
readChan :: Chan a -> IO a
readChan (Chan readVar _) = do
  stream <- takeMVar readVar            -- <1>
  Item val tail <- takeMVar stream      -- <2>
  putMVar readVar tail                  -- <3>
  return val
-- >>

-- <<dupChan
dupChan :: Chan a -> IO (Chan a)
dupChan (Chan _ writeVar) = do
  hole <- readMVar writeVar
  newReadVar <- newMVar hole
  return (Chan newReadVar writeVar)
-- >>

-- main = do
--   c <- newChan
--   writeChan c 'a'
--   readChan c >>= print

main = do
  c <- newChan
  writeChan c 'a'
  -- writeChan c 'x'
  readChan c >>= print
  c2 <- dupChan c
  -- writeChan c 'y'
  -- writeChan c 'z'
  writeChan c 'b'
  readChan c >>= print
  readChan c2 >>= print