module Position where

data Position = Position { row :: Int, col :: Int }

-- Translating a position
translate :: Position -> Position -> Position
translate (Position row col) (Position drow dcol) =
  Position (row + drow) (col + dcol)
