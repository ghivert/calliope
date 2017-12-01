module View.Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Types exposing (..)

view : Model -> Html Msg
view model =
  Html.div []
    [ header model ]

header : Model -> Html Msg
header model =
  Html.div
    [ Html.Attributes.class "header" ]
    [ searchField model
    , profileIcon model
    ]

searchField : Model -> Html Msg
searchField model =
  Html.span
    [ Html.Attributes.class "omnisearch" ]
    [ Html.input
      [ Html.Attributes.type_ "text"
      , Html.Attributes.placeholder "Search"
      ]
      []
    ]

profileIcon : Model -> Html Msg
profileIcon model =
  Html.div
    [ Html.Attributes.class "flex align-center cursor-pointer" ]
    [ Html.i
      [ Html.Attributes.class "fa fa-angle-down padding-horizontal-medium" ]
      []
    , Html.span
      [ Html.Attributes.class "profile-name" ]
      [ Html.text "Guillaume Hivert" ]
    , Html.img
      [ Html.Attributes.src "images/portrait.jpg"
      , Html.Attributes.class "profile-picture"
      ]
      []
    ]
