module Types where

import Control.Monad.State

data Tile = Player
          | Spawn
          | Empty
          | Wall
          | Finish

newtype Board = Board { tiles :: [[Tile]] }

type GameState a = StateT Board IO a
