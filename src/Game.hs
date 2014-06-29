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

-- Getting a board from a GameState
getBoard :: GameState Board
getBoard = state $ \board -> (board, board)

-- Starting a game
startGame :: Vty -> FilePath -> IO ()
startGame vty fp = do
  board <- loadBoard fp
  evalStateT (gameLoop vty) $ board
  shutdown vty

-- The game loop
gameLoop :: Vty -> GameState ()
gameLoop vty = do
  renderGame vty
  updateGame vty

-- Rendering the game
renderGame :: Vty -> GameState ()
renderGame vty = getBoard >>= liftIO . update vty . generateBoardPicture

-- Updating the game
updateGame :: Vty -> GameState ()
updateGame vty = do
  input <- liftIO $ nextEvent vty
  updateGame' vty input
  where updateGame' :: Vty -> Event -> GameState ()
        updateGame' vty event
          | event == EvKey (KChar quitKey ) [] = return ()
          | event == EvKey (KChar upKey   ) [] = moveUp    >> gameLoop vty
          | event == EvKey (KChar downKey ) [] = moveDown  >> gameLoop vty
          | event == EvKey (KChar leftKey ) [] = moveLeft  >> gameLoop vty
          | event == EvKey (KChar rightKey) [] = moveRight >> gameLoop vty
          | otherwise                          = gameLoop vty
