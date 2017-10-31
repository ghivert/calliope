module Electron.BrowserWindow exposing (BrowserWindow, open)

import Dict exposing (Dict)
import ParseInt as Parse
import Effects

type alias BrowserWindow =
  Effects.BrowserWindow

open : String -> List (String, String) -> Cmd msg
open url options =
  options
    |> Dict.fromList
    |> flip convertOptions (defaultBrowserWindow url)
    |> Effects.newBrowserWindow



defaultBrowserWindow : String -> BrowserWindow
defaultBrowserWindow url =
  Effects.BrowserWindow url Nothing Nothing Nothing Nothing Nothing



convertOptions : Dict String String -> BrowserWindow -> BrowserWindow
convertOptions options browserWindow =
  browserWindow
    |> ignoreMaybe "width" (parseAndSetString setWidth) options
    |> ignoreMaybe "height" (parseAndSetString setHeight) options
    |> ignoreMaybe "show" (parseAndSetBool setShow) options

ignoreMaybe
  : String
  -> (String -> BrowserWindow -> BrowserWindow)
  -> Dict String String
  -> BrowserWindow
  -> BrowserWindow
ignoreMaybe key transformAndSet options browserWindow =
  case Dict.get key options of
    Nothing ->
      browserWindow
    Just value ->
      transformAndSet value browserWindow

parseAndSetString
    : (Int -> BrowserWindow -> BrowserWindow)
    -> String
    -> BrowserWindow
    -> BrowserWindow
parseAndSetString setter value browserWindow =
  value
    |> Parse.parseInt
    |> ignoreError setter browserWindow

parseAndSetBool
    : (Bool -> BrowserWindow -> BrowserWindow)
    -> String
    -> BrowserWindow
    -> BrowserWindow
parseAndSetBool setter value browserWindow =
  value
    |> parseBool
    |> ignoreError setter browserWindow

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

parseBool : String -> Result String Bool
parseBool value =
  case value of
    "true" ->
      Ok True
    "false" ->
      Ok False
    _ ->
      Err "Not a bool"



setWidth : Int -> BrowserWindow -> BrowserWindow
setWidth width browserWindow =
  { browserWindow | width = Just width }

setHeight : Int -> BrowserWindow -> BrowserWindow
setHeight height browserWindow =
  { browserWindow | height = Just height }

setShow : Bool -> BrowserWindow -> BrowserWindow
setShow show browserWindow =
  { browserWindow | show = Just show }
