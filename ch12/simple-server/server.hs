{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE MultiWayIf #-}
module Main (main) where

import Network
import Control.Monad
import Control.Concurrent (forkIO, forkFinally)
import System.IO
import Text.Printf
import Control.Exception
import GHC.IO.Exception
import Data.IORef
import Data.Time

-- <<main
main :: IO ()
main = withSocketsDo $ do
  sock <- listenOn (PortNumber (fromIntegral port))
  printf "Listening on port %d\n" port

  clientNum  <- newIORef 0

  try (loop clientNum sock) >>= \case
    Left err -> print $ fromException @AsyncException err
    Right _ -> pure ()

  where
    loop clientNum sock = forever $ do
      (handle, host, port) <- accept sock
      let
        incClient = modifyIORef clientNum (+1)
        decClient = modifyIORef clientNum (subtract 1)
        finallyAction = hClose handle >> decClient

      printf "Accepted connection from %s: %s\n" host (show port)
      forkFinally (incClient >> talk clientNum (host,port) handle) $ \case
        Left e -> putStrLn (displayException e) >> finallyAction
        Right _ -> finallyAction

port :: Int
port = 44444

maxClient :: Int
maxClient = 2
-- >>

-- <<talk
talk :: IORef Int -> (String, PortNumber) -> Handle -> IO ()
talk clientNum (host,port) h = do
  hSetBuffering h LineBuffering
  n <- readIORef clientNum
  if n > maxClient
    then do
      printf "Close connection from %s: %s\n" host (show port)
      hPutStrLn h "Sorry, goodbye. (Connections is too many)"
    else loop
 where
  loop =
    hGetLine h >>= \case
      "end" -> hPutStrLn h "Thank you for using the Haskell doubling service."
      line -> do
        writeLog line
        hPutStrLn h $ show (2 * read @Integer line)
        loop

  writeLog :: String -> IO ()
  writeLog s = do
    time <- show <$> getZonedTime
    let msg = printf "【%s】%s (%s): %s \n" time host (show port) s
    appendFile "server.log" msg
-- >>