module Electron.BrowserWindow exposing (..)

import Color exposing (Color)
import Dict exposing (Dict)
import ParseInt as Parse

type alias BrowserWindow =
  { width : Maybe Int
  , height : Maybe Int
  , backgroundColor : Maybe Color
  , coordinates : Maybe { x : Int, y : Int }
  }

open : String -> List (String, String) -> Cmd msg
open url options =
  options
    |> Dict.fromList
    |> convertOptions
    |> Native.BrowserWindow.new

convertOptions : Dict String String -> BrowserWindow -> BrowserWindow
convertOptions options browserWindow =
  browserWindow
    |> ignoreMaybe "width" options

ignoreMaybe : String -> Dict String String -> BrowserWindow -> BrowserWindow
ignoreMaybe key options browserWindow =
  case Dict.get key options of
    Nothing ->
      browserWindow
    Just value ->
      value
        |> Parse.parseInt
        |> ignoreError setWidth browserWindow

ignoreError
  : (a -> BrowserWindow -> BrowserWindow)
  -> BrowserWindow
  -> Result error a
  -> BrowserWindow
ignoreError setter browserWindow result =
  case result of
    Ok value ->
      setter value browserWindow
    Err _ ->
      browserWindow

setWidth : Int -> BrowserWindow -> BrowserWindow
setWidth width browserWindow =
  { browserWindow | width = Just width }
