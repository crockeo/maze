module Move where

import Control.Monad.State

import Types
import Utils

getTileRaw :: Board -> Position -> Tile
getTileRaw (Board tiles) (Position row col) = tiles !! row !! col

-- Getting the player position
playerPosition :: GameState Position
playerPosition =
  state $ \game ->
    let poses = [Position row col | row <- [0 .. (boardHeight $ board game) - 1]
                                  , col <- [0 .. (boardWidth  $ board game) - 1]] in
    (head $ filter (\pos -> getTileRaw (board game) pos == Player) poses, game)

-- Getting the tile at a postion
getTile :: Position -> GameState Tile
getTile pos =
  state $ \game ->
    (getTileRaw (board game) pos, game)

-- Setting  a  tile at a position
setTile :: Position -> Tile -> GameState ()
setTile (Position row col) tile =
  state $ \g@(Game (Board tiles) _) ->
    ((), g { board = Board $ replace2D tile tiles row col })

-- Moving an arbitrary direction
moveDirection :: Direction -> GameState Bool
moveDirection dir = do
  playerPos <- playerPosition
  let newPos = translate playerPos $ toPosition dir
  
  newCurrent <- getTile newPos
  case newCurrent of
    Wall   -> return False
    Finish -> return True
    Empty  -> do
      setTile playerPos Empty
      setTile newPos    Player
      return False

moveUp    = moveDirection Upwards
moveDown  = moveDirection Downwards
moveLeft  = moveDirection Leftwards
moveRight = moveDirection Rightwards
