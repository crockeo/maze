module Game (startGame) where

import Control.Monad.State

import Graphics.Vty.Input.Events
import Graphics.Vty

import Display
import Types
import Move

-- Key config
quitKey  = 'q'
upKey    = 'w'
downKey  = 's'
leftKey  = 'a'
rightKey = 'd'

-- Starting a game
startGame :: Vty -> FilePath -> IO ()
startGame vty fp = do
  board <- loadBoard fp
  evalStateT gameLoop $ Game { board = board
                             , vty   = vty
                             , won   = False
                             }
  shutdown vty

-- The game loop
gameLoop :: GameState ()
gameLoop = do
  won <- hasWon

  if won
    then renderWon
    else renderGame >> updateGame

-- Rendering a won screen
renderWon :: GameState ()
renderWon = undefined

-- Rendering the game
renderGame :: GameState ()
renderGame = do
  board <- getBoard
  vty   <- getVty
  liftIO $ update vty $ generateBoardPicture board

-- Updating the game
updateGame :: GameState ()
updateGame = do
  vty   <- getVty
  input <- liftIO $ nextEvent vty
  updateGame' vty input
  where updateGame' :: Vty -> Event -> GameState ()
        updateGame' vty event
          | event == EvKey (KChar quitKey ) [] = return ()
          | event == EvKey (KChar upKey   ) [] = moveUp    >> gameLoop
          | event == EvKey (KChar downKey ) [] = moveDown  >> gameLoop
          | event == EvKey (KChar leftKey ) [] = moveLeft  >> gameLoop
          | event == EvKey (KChar rightKey) [] = moveRight >> gameLoop
          | otherwise                          = gameLoop
