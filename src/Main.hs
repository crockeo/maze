module Main where

import Graphics.Vty.Config
import Graphics.Vty

import System.Environment

import Game

main :: IO ()
main = do
  args <- getArgs
  
  if length args >= 2
    then putStrLn "Proper usage: maze [filepath]"
    else do
      let path = "boards/" ++ case args of
                                (bp:[]) -> bp
                                l       -> "testboard"

      vty <- mkVty $ Config { vmin     = Just 1
                            , vtime    = Just 100
                            , debugLog = Nothing
                            , inputMap = []
                            }

      startGame vty path
