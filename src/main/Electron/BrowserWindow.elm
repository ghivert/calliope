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
  Effects.BrowserWindow url Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing



convertOptions : Dict String String -> BrowserWindow -> BrowserWindow
convertOptions options browserWindow =
  browserWindow
    |> ignoreMaybe "width" (parseAndSetString setWidth) options
    |> ignoreMaybe "height" (parseAndSetString setHeight) options
    |> ignoreMaybe "show" (parseAndSetBool setShow) options
    |> ignoreMaybe "transparent" (parseAndSetBool setTransparent) options
    |> ignoreMaybe "frame" (parseAndSetBool setFrame) options
    |> ignoreMaybe "titleBarStyle" (parseAndSetTitleBarStyle setTitleBarStyle) options
    |> ignoreMaybe "vibrancy" (parseAndSetVibrancy setVibrancy) options

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

parseAndSetTitleBarStyle
    : (String -> BrowserWindow -> BrowserWindow)
    -> String
    -> BrowserWindow
    -> BrowserWindow
parseAndSetTitleBarStyle setter value browserWindow =
  value
    |> parseTitleBarStyle
    |> ignoreError setter browserWindow

parseAndSetVibrancy
    : (String -> BrowserWindow -> BrowserWindow)
    -> String
    -> BrowserWindow
    -> BrowserWindow
parseAndSetVibrancy setter value browserWindow =
  value
    |> parseVibrancy
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

parseTitleBarStyle : String -> Result String String
parseTitleBarStyle value =
  case value of
    "hidden" ->
      Ok "hidden"
    "hiddenInset" ->
      Ok "hiddenInset"
    "customButtonsOnHover" ->
      Ok "customButtonsOnHover"
    _ ->
      Err "Not an option"

parseVibrancy : String -> Result String String
parseVibrancy value =
  case value of
    "appearance-based" ->
      Ok "appearance-based"
    "light" ->
      Ok "light"
    "dark" ->
      Ok "dark"
    "titlebar" ->
      Ok "titlebar"
    "selection" ->
      Ok "selection"
    "menu" ->
      Ok "menu"
    "popover" ->
      Ok "popover"
    "sidebar" ->
      Ok "sidebar"
    "medium-light" ->
      Ok "medium-light"
    "ultra-dark" ->
      Ok "ultra-dark"
    _ ->
      Err "Not an option"



setWidth : Int -> BrowserWindow -> BrowserWindow
setWidth width browserWindow =
  { browserWindow | width = Just width }

setHeight : Int -> BrowserWindow -> BrowserWindow
setHeight height browserWindow =
  { browserWindow | height = Just height }

setShow : Bool -> BrowserWindow -> BrowserWindow
setShow show browserWindow =
  { browserWindow | show = Just show }

setTransparent : Bool -> BrowserWindow -> BrowserWindow
setTransparent transparent browserWindow =
  { browserWindow | transparent = Just transparent }

setFrame : Bool -> BrowserWindow -> BrowserWindow
setFrame frame browserWindow =
  { browserWindow | frame = Just frame }

setVibrancy : String -> BrowserWindow -> BrowserWindow
setVibrancy vibrancy browserWindow =
  { browserWindow | vibrancy = Just vibrancy }

setTitleBarStyle : String -> BrowserWindow -> BrowserWindow
setTitleBarStyle titleBarStyle browserWindow =
  { browserWindow | titleBarStyle = Just titleBarStyle }
