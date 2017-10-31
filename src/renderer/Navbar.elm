module Navbar exposing (view)

import Html exposing (Html)
import Types exposing (..)

view : Model -> Html Msg
view model =
  Html.nav []
    [ roomView model
    , musicNavbar model
    , playlistsView model
    , coverAlbumView model
    ]

roomView : Model -> Html Msg
roomView model =
  Html.div [] []

musicNavbar : Model -> Html Msg
musicNavbar model =
  Html.div [] []

playlistsView : Model -> Html Msg
playlistsView model =
  Html.div [] []

coverAlbumView : Model -> Html Msg
coverAlbumView model =
  Html.div [] []
