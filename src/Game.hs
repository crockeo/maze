module Game (startGame) where

import Control.Monad.State

import Graphics.Vty.Input.Events
import Graphics.Vty

import Display
import Board

data Game = Game { vty    :: Vty
                 , board  :: Board
                 , width  :: Int
                 , height :: Int
                 }

type GameState a = State Game a

startGame :: Vty -> FilePath -> IO ()
startGame vty fp = do
  board <- loadBoard fp
  gameLoop $ Game { vty    = vty
                  , board  = board
                  , width  = length $        tiles board
                  , height = length $ head $ tiles board
                  }

gameLoop :: Game -> IO ()
gameLoop game = do
  update (vty game) (generateBoardPicture $ board game)

  event <- nextEvent $ vty game
  case event of
    EvKey (KChar 'q') [] -> shutdown $ vty game
    other                -> gameLoop game
