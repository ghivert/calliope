module View.Navbar exposing (view)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Types exposing (..)
import Rocket exposing ((=>))

view : Model -> Html Msg
view model =
  Html.nav
    [ Html.Attributes.class "navbar" ]
    [ textualElements
      [ musicNavbar model
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

itemIcon : Int -> String -> Html Msg
itemIcon rowIn icon =
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

itemLabel : Int -> String -> Html Msg
itemLabel rowIn label =
  let row = toString rowIn in
  Html.div
    [ Html.Attributes.class "dark-grey-text"
    , Html.Attributes.style
      [ "grid-column" => "2 / 2"
      , "grid-row" => row ++ " / " ++ row
      , "font-weight" => "600"
      , "font-size" => "0.8rem"
      , "justify-self" => "left"
      , "align-self" => "center"
      ]
    ]
    [ Html.text label ]

itemLabeledIcon : Int -> String -> String -> List (Html Msg)
itemLabeledIcon row icon label =
  [ itemIcon  row icon
  , itemLabel row label
  ]

musicNavbar : Model -> Html Msg
musicNavbar model =
  Html.div []
    [ Html.h1 [] [ Html.text "Music" ]
    , Html.div
      [ Html.Attributes.class "music" ]
      <| List.concat
        [ itemLabeledIcon 1 "fa-music" "Songs"
        , itemLabeledIcon 2 "fa-square" "Albums"
        , itemLabeledIcon 3 "fa-microphone" "Artists"
        , itemLabeledIcon 4 "fa-heart" "Liked"
        ]
    ]

playlistsView : Model -> Html Msg
playlistsView model =
  Html.div []
    [ Html.h1 [] [ Html.text "Playlists" ]
    , Html.div
      [ Html.Attributes.class "playlists" ]
      []
    , Html.div
      [ Html.Attributes.class "add-playlist"
      , Html.Events.onClick AddPlaylist
      ]
      (itemLabeledIcon 1 "fa-plus" "New playlist...")
    ]

coverAlbumView : Model -> Html Msg
coverAlbumView model =
  Html.div
    [ Html.Attributes.class "cover-image" ]
    [ Html.img
      [ Html.Attributes.src "images/cover.jpg" ]
      []
    ]
