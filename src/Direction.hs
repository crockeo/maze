module Direction where

import Position

data Direction = Upwards
               | Downwards
               | Leftwards
               | Rightwards

-- Converting a direction to a position
toPosition :: Direction -> Position
toPosition Upwards    = Position { row = -1, col =  0 }
toPosition Downwards  = Position { row =  1, col =  0 }
toPosition Leftwards  = Position { row =  0, col = -1 }
toPosition Rightwards = Position { row =  0, col =  1 }
