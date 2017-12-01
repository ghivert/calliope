module Html.Extra exposing (..)

import Html exposing (Html)
import Html.Attributes

none : Html msg
none =
  Html.text ""

separator : Html msg
separator =
  Html.hr
    [ Html.Attributes.class "separator" ]
    []
