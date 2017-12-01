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
    [ Html.Attributes.class "flex" ]
    [ searchField model
    , profileIcon model
    ]

searchField : Model -> Html Msg
searchField model =
  Html.input
    [ Html.Attributes.type_ "text"
    , Html.Attributes.placeholder "Search"
    ]
    []

profileIcon : Model -> Html Msg
profileIcon model =
  Html.div []
    [ Html.span [] [ Html.text "name" ]
    , Html.img [] []
    ]
