module Types where

import Control.Monad.State

import Board

type GameState a = StateT Board IO a
