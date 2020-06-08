{-# LANGUAGE BangPatterns #-}
import Control.DeepSeq
import Control.Monad.Par

data IList a
  = Nil
  | Cons a (IVar (IList a))

type Stream a = IVar (IList a)

instance NFData a => NFData (IList a) where
  rnf Nil = ()
  rnf (Cons a b) = rnf a `seq` rnf b

streamFromList :: NFData a => [a] -> Par (Stream a)
streamFromList xs = do
  var <- new
  fork $ loop xs var
  return var
  where
    loop [] var = put var Nil
    loop (x:xs) var = do
      tail <- new
      put var (Cons x tail)
      loop xs tail

streamFold :: (a -> b -> a) -> a -> Stream b -> Par a
streamFold fn !acc instrm = do
  ilst <- get instrm
  case ilst of
    Nil -> return acc
    Cons h t -> streamFold fn (fn acc h) t

streamMap :: NFData b => (a -> b) -> Stream a -> Par (Stream b)
streamMap fn instrm = do
  outstrm <- new
  fork $ loop instrm outstrm
  return outstrm
  where
    loop instrm outstrm = do
      ilst <- get instrm
      case ilst of
        Nil -> put outstrm Nil
        Cons h t -> do
          newtl <- new
          put outstrm (Cons (fn h) newtl)
          loop t newtl