module Board where

import Utils

data Tile = Player
          | Empty
          | Wall
          | Finish

newtype Board = Board { tiles :: [[Tile]] }

-- Converting a tile to its display char
displayTile :: Tile -> Char
displayTile Player = '@'
displayTile Empty  = '.'
displayTile Wall   = '#'
displayTile Finish = '^'

-- Converting a char to a tile
readTile :: Char -> Tile
readTile '@' = Player
readTile '.' = Empty
readTile '#' = Wall
readTile '^' = Finish

-- Reading a board
readBoard :: String -> Board
readBoard str = Board $  map (map readTile) $ lines str

-- Loading a board from file
loadBoard :: FilePath -> IO Board
loadBoard fp = readFile fp >>= return . readBoard
