module Navbar exposing (view)

import Html exposing (Html)
import Html.Attributes
import Types exposing (..)
import Rocket exposing ((=>))
import Color
import Color.Convert

view : Model -> Html Msg
view model =
  Html.nav
    [ Html.Attributes.class "navbar" ]
    [ textualElements
      [ roomView model
      , musicNavbar model
      , playlistsView model
      ]
    , coverAlbumView model
    ]

textualElements : List (Html Msg) -> Html Msg
textualElements =
  Html.div [ Html.Attributes.class "huge-padding" ]

roomCard : Bool -> Int -> String -> Html Msg
roomCard active number label =
  Html.div
    [ Html.Attributes.class "wrapper" ]
    [ Html.div
      [ Html.Attributes.classList
        [ "column card" => True
        , "active" => active
        ]
      ]
      [ Html.div
        [ Html.Attributes.class "number" ]
        [ Html.text <| toRoomCardIndex number ]
      , Html.div
        [ Html.Attributes.class "text" ]
        [ Html.text label ]
      ]
    ]

toRoomCardIndex : Int -> String
toRoomCardIndex numberIn =
  let number = toString numberIn in
  if numberIn < 10 then
    "0" ++ number
  else
    number

roomView : Model -> Html Msg
roomView model =
  Html.div []
    [ Html.h1 [] [ Html.text "Rooms" ]
    , Html.div
      [ Html.Attributes.class "row" ]
      [ roomCard True  1 "our office"
      , roomCard False 2 "kitchen"
      , roomCard False 3 "garage"
      , roomCard False 4 "garden"
      ]
    ]

musicIcon : Int -> String -> Html Msg
musicIcon rowIn icon =
  let row = toString rowIn in
  Html.div
    [ Html.Attributes.style
      [ "grid-column" =>  "1 / 1"
      , "grid-row" => row ++ " / " ++ row
      , "align-self" => "center"
      , "justify-self" => "center"
      ]
    ]
    [ Html.i
      [ Html.Attributes.class <| "grey-text padding-right fa " ++ icon ]
      []
    ]

musicLabel : Int -> String -> Html Msg
musicLabel rowIn label =
  let row = toString rowIn in
  Html.div
    [ Html.Attributes.style
      [ "grid-column" => "2 / 2"
      , "grid-row" => row ++ " / " ++ row
      , "color" => (Color.rgb 75 75 75 |> Color.Convert.colorToCssRgb)
      , "font-weight" => "600"
      , "font-size" => "0.8em"
      ]
    ]
    [ Html.text label ]

musicLabeledIcon : Int -> String -> String -> List (Html Msg)
musicLabeledIcon row icon label =
  [ musicIcon  row icon
  , musicLabel row label
  ]

musicNavbar : Model -> Html Msg
musicNavbar model =
  Html.div []
    [ Html.h1 [] [ Html.text "Music" ]
    , Html.div
      [ Html.Attributes.class "music" ]
      <| List.concat
        [ musicLabeledIcon 1 "fa-music" "Songs"
        , musicLabeledIcon 2 "fa-square" "Albums"
        , musicLabeledIcon 3 "fa-microphone" "Artists"
        , musicLabeledIcon 4 "fa-heart" "Liked"
        ]
    ]

playlistsView : Model -> Html Msg
playlistsView model =
  Html.div [] [ Html.h1 [] [ Html.text "Playlists" ] ]

coverAlbumView : Model -> Html Msg
coverAlbumView model =
  Html.div
    [ Html.Attributes.class "cover-image" ]
    [ Html.img
      [ Html.Attributes.src "images/cover.jpg" ]
      []
    ]
