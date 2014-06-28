module Display where

import Graphics.Vty.Attributes
import Graphics.Vty.Image
import Graphics.Vty

import Board

-- Generating styling for a Tile
generateAttr :: Tile -> Attr
generateAttr Player = defAttr `withForeColor` green
generateAttr Spawn  = defAttr `withForeColor` green
generateAttr Empty  = defAttr `withForeColor` black
generateAttr Wall   = defAttr `withForeColor` white
generateAttr Finish = defAttr `withForeColor` blue

-- Generating an image for a line of tiles
generateLine :: [Tile] -> Image
generateLine =
  horizCat . generateLine'
  where generateLine' :: [Tile] -> [Image]
        generateLine' []     = []
        generateLine' (x:xs) = char (generateAttr x) (displayTile x) : generateLine' xs

-- Generating an image for a board
generateBoardImage :: Board -> Image
generateBoardImage (Board tss) = vertCat $ map generateLine tss

-- Making the board image into a picture
generateBoardPicture :: Board -> Picture
generateBoardPicture = picForImage . generateBoardImage
