module Electron.BrowserWindow.Shared exposing (..)

import Color exposing (Color)

{-| Represents the coordinates of the newly instanciate of the BrowserWindow. -}
type alias Coordinates =
  { x : Int
  , y : Int
  }

{-| Represents a BrowserWindow in the Electron World. -}
type alias BrowserWindow =
  { url : String
  , width : Maybe Int
  , height : Maybe Int
  , backgroundColor : Maybe Color
  , coordinates : Maybe Coordinates
  , show : Maybe Bool
  , transparent : Maybe Bool
  , frame : Maybe Bool
  , titleBarStyle : Maybe String
  , vibrancy : Maybe String
  }
