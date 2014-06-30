module Types ( module TypesExport
             , Game (..)
             , GameState
             , getBoard
             , getVty
             , hasWon
             ) where

import Control.Monad.State
import Graphics.Vty

import Direction as TypesExport
import Position  as TypesExport
import Board     as TypesExport

data Game = Game { board :: Board
                 , vty   :: Vty
                 , won   :: Bool
                 }

type GameState a = StateT Game IO a

-- Getting the board from a game
getBoard :: GameState Board
getBoard = state $ \game -> (board game, game)

-- Getting the Vty instance from a game
getVty :: GameState Vty
getVty = state $ \game -> (vty game, game)

-- Getting whether or not the user has one
hasWon :: GameState Bool
hasWon = state $ \game -> (won game, game)
