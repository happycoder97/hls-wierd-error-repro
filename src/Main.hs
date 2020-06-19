{-# LANGUAGE FlexibleContexts #-}

module Main where

import Control.Monad.State.Strict

main :: IO ()
main = do
  ss <- execStateT foo []
  putStrLn "You entered:"
  printList ss
  where
    printList ss =
      case ss of
        [] -> return ()
        (s:ss) -> do
          putStrLn $ "| " ++ s
          printList ss


-- Steps to reproduce
-- Put a stray character anywhere in the following function

foo :: (MonadState [String] m, MonadIO m) => m ()
foo = do
  liftIO $ putStrLn "Enter a string"
  s <- liftIO $ getLine
  if s == "STOP"
    then return ()
    else do
      modify $ \ss -> s : ss
      foo
