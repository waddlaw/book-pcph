{-# LANGUAGE LambdaCase #-}
module TMVar2 where

import Control.Concurrent
import Control.Concurrent.STM hiding (TMVar, takeTMVar, newTMVar, newEmptyTMVar, putTMVar)

-- <<TMVar
data TMVar a = TMVar (TVar (Maybe a)) (TVar [TVar (Maybe a)])
-- >>

newTMVar :: a -> STM (TMVar a)
newTMVar a = do
  t <- newTVar (Just a)
  t' <- newTVar []
  return (TMVar t t')

-- <<newEmptyTMVar
newEmptyTMVar :: STM (TMVar a)
newEmptyTMVar = do
  t <- newTVar Nothing
  t' <- newTVar []
  return (TMVar t t')
-- >>

-- <<takeTMVar
takeTMVar :: TMVar a -> STM a
takeTMVar (TMVar t t') = do
  readTVar t >>= \case
    Nothing -> do
      m <- newTVar Nothing
      blocks <- readTVar t'
      writeTVar t' (blocks ++ [m])
      retry

    Just a -> do
      writeTVar t Nothing
      return a
-- >>

-- -- <<putTMVar
putTMVar :: TMVar a -> a -> STM ()
putTMVar (TMVar t t') a = do
  readTVar t >>= \case
    -- TMVar が空
    Nothing ->
      readTVar t' >>= \case
        -- ブロックされている takeTMVar は無い
        [] -> writeTVar t (Just a)

        -- いくつかの takeTMVar がブロックされている
        (x:xs) -> do
          writeTVar x (Just a)
          writeTVar t' xs

    -- TMVar が満杯
    Just _ -> do
      m <- newTVar (Just a)
      blocks <- readTVar t'
      writeTVar t' (blocks ++ [m])
      retry
-- -- >>

-- main :: IO ()
-- main = do
--   m <- atomically newEmptyTMVar
--   forkIO $ atomically $ putTMVar m 'x'
--   r <- atomically $ takeTMVar m
--   print r
-- main = do
--   m <- atomically $ newEmptyTMVar
--   forkIO $ atomically $ do putTMVar m 'x'; putTMVar m 'y'
--   r <- atomically $ takeTMVar m
--   print r
--   r <- atomically $ takeTMVar m
--   print r