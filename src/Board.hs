module Board where

import Types
import Utils

-- Converting a tile to its display char
displayTile :: Tile -> Char
displayTile Player = '@'
displayTile Spawn  = '!'
displayTile Empty  = '.'
displayTile Wall   = '#'
displayTile Finish = '^'

-- Converting a char to a tile
readTile :: Char -> Tile
readTile '@' = Player
readTile '!' = Spawn
readTile '.' = Empty
readTile '#' = Wall
readTile '^' = Finish

-- Reading a board
readBoard :: String -> Board
readBoard str = Board $  map (map readTile) $ lines str

-- Loading a board from file
loadBoard :: FilePath -> IO Board
loadBoard fp = readFile fp >>= return . readBoard
