module Types ( module TypesExport
             , Game (..)
             , GameState
             , getBoard
             , getVty
             ) where

import Control.Monad.State
import Graphics.Vty

import Direction as TypesExport
import Position  as TypesExport
import Board     as TypesExport

data Game = Game { board :: Board
                 , vty   :: Vty
                 }

type GameState a = StateT Game IO a

-- Getting the board from a game
getBoard :: GameState Board
getBoard =
  state $ \g@(Game board _) -> (board, g)

-- Getting the Vty instance from a game
getVty :: GameState Vty
getVty =
  state $ \g@(Game _ vty) -> (vty, g)
