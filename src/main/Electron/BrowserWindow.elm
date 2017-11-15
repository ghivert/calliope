module Electron.BrowserWindow exposing (BrowserWindow, open)

import Electron.BrowserWindow.Shared as BrowserWindow
import Dict exposing (Dict)
import ParseInt as Parse
import Effects
import Maybe.Extra.Infix exposing ((>>=))
import Color exposing (Color)
import Color.Convert

{-| Represents a BrowserWindow in the Electron World. -}
type alias BrowserWindow =
  BrowserWindow.BrowserWindow

{-| Open a new BrowserWindow. The only required parameter is the url
  of the linked file. The assoc contains options which should be passed
  to the BrowserWindow. -}
open : String -> List (String, String) -> Cmd msg
open url options =
  options
    |> Dict.fromList
    |> createBrowserWindow url
    |> Effects.newBrowserWindow



createBrowserWindow : String -> Dict String String -> BrowserWindow
createBrowserWindow url options =
  BrowserWindow.BrowserWindow url
    (Dict.get "width" options >>= parseInt)
    (Dict.get "height" options >>= parseInt)
    (Dict.get "backgroundColor" options >>= parseColor)
    (Dict.get "coordinates" options >>= parseCoordinates)
    (Dict.get "show" options >>= parseBool)
    (Dict.get "transparent" options >>= parseBool)
    (Dict.get "frame" options >>= parseBool)
    (Dict.get "titleBarStyle" options >>= parseTitleBarStyle)
    (Dict.get "vibrancy" options >>= parseVibrancy)

parseInt : String -> Maybe Int
parseInt =
  Parse.parseInt >> Result.toMaybe

parseBool : String -> Maybe Bool
parseBool =
  parseBool_ >> Result.toMaybe

parseTitleBarStyle : String -> Maybe String
parseTitleBarStyle =
  parseTitleBarStyle_ >> Result.toMaybe

parseVibrancy : String -> Maybe String
parseVibrancy =
  parseVibrancy_ >> Result.toMaybe

parseColor : String -> Maybe Color
parseColor =
  Color.Convert.hexToColor >> Result.toMaybe

parseCoordinates : String -> Maybe BrowserWindow.Coordinates
parseCoordinates =
  always Nothing

parseBool_ : String -> Result String Bool
parseBool_ value =
  case value of
    "true" ->
      Ok True
    "false" ->
      Ok False
    _ ->
      Err "Not a bool"

parseTitleBarStyle_ : String -> Result String String
parseTitleBarStyle_ value =
  case value of
    "hidden" ->
      Ok "hidden"
    "hiddenInset" ->
      Ok "hiddenInset"
    "customButtonsOnHover" ->
      Ok "customButtonsOnHover"
    _ ->
      Err "Not an option"

parseVibrancy_ : String -> Result String String
parseVibrancy_ value =
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
