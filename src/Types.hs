module Types (module TypesExport, GameState) where

import Control.Monad.State

import Direction as TypesExport
import Position  as TypesExport
import Board     as TypesExport

type GameState a = StateT Board IO a
