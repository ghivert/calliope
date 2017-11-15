module Navbar exposing (view)

import Html exposing (Html)
import Html.Attributes
import Types exposing (..)

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

roomView : Model -> Html Msg
roomView model =
  Html.div []
    [ Html.h1 [] [ Html.text "Rooms" ]
    , Html.div
      [ Html.Attributes.class "row" ]
      [ Html.div
        [ Html.Attributes.class "wrapper" ]
        [ Html.div
          [ Html.Attributes.class "column card active" ]
          [ Html.div [ Html.Attributes.class "number" ] [ Html.text "01" ]
          , Html.div [ Html.Attributes.class "text" ] [ Html.text "office" ]
          ]
        ]
      , Html.div
        [ Html.Attributes.class "wrapper" ]
        [ Html.div
          [ Html.Attributes.class "column card" ]
          [ Html.div [ Html.Attributes.class "number" ] [ Html.text "02" ]
          , Html.div [ Html.Attributes.class "text" ] [ Html.text "kitchen" ]
          ]
        ]
      , Html.div
        [ Html.Attributes.class "wrapper" ]
        [ Html.div
          [ Html.Attributes.class "column card" ]
          [ Html.div [ Html.Attributes.class "number" ] [ Html.text "03" ]
          , Html.div [ Html.Attributes.class "text" ] [ Html.text "garage" ]
          ]
        ]
      , Html.div
        [ Html.Attributes.class "wrapper" ]
        [ Html.div
          [ Html.Attributes.class "column card" ]
          [ Html.div [ Html.Attributes.class "number" ] [ Html.text "04" ]
          , Html.div [ Html.Attributes.class "text" ] [ Html.text "garden" ]
          ]
        ]
      ]
    ]

musicNavbar : Model -> Html Msg
musicNavbar model =
  Html.div []
    [ Html.h1 [] [ Html.text "Music" ]
    , Html.div
      [ Html.Attributes.class "column" ]
      [ Html.div
        [ Html.Attributes.class "chooser" ]
        [ Html.i
          [ Html.Attributes.class "grey-text padding-right fa fa-music" ] []
        , Html.span [] [ Html.text "Songs" ]
        ]
      , Html.div
        [ Html.Attributes.class "chooser" ]
        [ Html.i
          [ Html.Attributes.class "grey-text padding-right fa fa-square" ] []
        , Html.span [] [ Html.text "Albums" ]
        ]
      , Html.div
        [ Html.Attributes.class "chooser" ]
        [ Html.i
          [ Html.Attributes.class "grey-text padding-right fa fa-microphone" ] []
        , Html.span [] [ Html.text "Artists" ]
        ]
      , Html.div
        [ Html.Attributes.class "chooser" ]
        [ Html.i
          [ Html.Attributes.class "grey-text padding-right fa fa-heart" ] []
        , Html.span [] [ Html.text "Liked" ]
        ]
      ]
    ]

playlistsView : Model -> Html Msg
playlistsView model =
  Html.div []
    [ Html.h1 [] [ Html.text "Playlists" ] ]

coverAlbumView : Model -> Html Msg
coverAlbumView model =
  Html.div
    [ Html.Attributes.class "cover-image" ]
    [ Html.img
      [ Html.Attributes.src "http://lorempixel.com/400/400/" ]
      []
    ]
