module View.Navbar exposing (view)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Rocket exposing ((=>))

import Types exposing (..)
import Route

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

{-| Unused now. -}
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

{-| Unused now. -}
toRoomCardIndex : Int -> String
toRoomCardIndex numberIn =
  let number = toString numberIn in
  if numberIn < 10 then
    "0" ++ number
  else
    number

{-| Unused now. -}
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

itemIcon : Int -> String -> msg -> Html msg
itemIcon rowIn icon onClick =
  let row = toString rowIn in
  Html.div
    [ Html.Attributes.style
      [ "grid-column" =>  "1 / 1"
      , "grid-row" => row ++ " / " ++ row
      , "align-self" => "center"
      , "justify-self" => "center"
      , "cursor" => "pointer"
      ]
    ]
    [ Html.i
      [ Html.Attributes.class <| "grey-text padding-right fa " ++ icon
      , Html.Events.onClick onClick
      ]
      []
    ]

itemLabel : Int -> String -> msg -> Html msg
itemLabel rowIn label onClick =
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
      , "cursor" => "pointer"
      ]
    , Html.Events.onClick onClick
    ]
    [ Html.text label ]

itemLabeledIcon : Int -> String -> String -> msg -> List (Html msg)
itemLabeledIcon row icon label msg =
  [ itemIcon  row icon  msg
  , itemLabel row label msg
  ]

musicNavbar : Model -> Html Msg
musicNavbar model =
  Html.div []
    [ Html.h1 [] [ Html.text "Music" ]
    , Html.div
      [ Html.Attributes.class "music" ]
      <| List.concat
        [ itemLabeledIcon 1 "fa-home" "Home" (Navigation Route.Home)
        , itemLabeledIcon 2 "fa-music" "Songs" (Navigation Route.Songs)
        , itemLabeledIcon 3 "fa-square" "Albums" (Navigation Route.Albums)
        , itemLabeledIcon 4 "fa-microphone" "Artists" (Navigation Route.Artists)
        , itemLabeledIcon 5 "fa-heart" "Liked" (Navigation Route.Liked)
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
      (itemLabeledIcon 1 "fa-plus" "New playlist..." AddPlaylist)
    ]

coverAlbumView : Model -> Html Msg
coverAlbumView model =
  Html.div
    [ Html.Attributes.class "cover-image" ]
    [ Html.img
      [ Html.Attributes.src "images/cover.jpg" ]
      []
    ]
