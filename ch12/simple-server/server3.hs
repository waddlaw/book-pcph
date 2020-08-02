{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent (forkFinally)
import qualified Control.Exception as E
import Control.Monad (unless, forever, void)
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as B8
import Network.Socket
import Network.Socket.ByteString (recv, sendAll)
import Text.Printf
import Data.Maybe

main :: IO ()
main = do
  listenOn port $ \sock -> do
    printf "Listening on port %s\n" port
    forever $ do
      (conn, peer) <- accept sock
      printf "Accepted connection from %s\n" $ show peer
      forkFinally (talk conn) (const $ gracefulClose conn 5000)

port :: String
port = "44444"

talk :: Socket -> IO ()
talk s = loop
  where
    loop = do
      line <- recv s 1024
      if line == "end"
        then sendAll s "Thank you for using the Haskell doubling service."
        else do
          sendAll s $ B8.pack $ show (2 * (read $ B8.unpack $ line))
          loop

listenOn :: String -> (Socket -> IO ()) -> IO ()
listenOn port' loop = do
    addr <- resolve
    E.bracket (open addr) close loop
  where
    resolve = do
        let hints = defaultHints
                      { addrFlags = [AI_PASSIVE]
                      , addrSocketType = Stream
                      }
        head <$> getAddrInfo (Just hints) Nothing (Just port')
    open addr = do
        sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
        setSocketOption sock ReuseAddr 1
        withFdSocket sock $ setCloseOnExecIfNeeded
        bind sock $ addrAddress addr
        listen sock 1024
        return sock