module Renderer exposing (..)

import Html exposing (Html)

main : Html msg
main =
  Html.div []
    [ Html.text "Hello from Elm!"
    , Html.br [] []
    , Html.text "Electron is awesome!"
    , Html.br [] []
    , Html.text "Elm too!"
    ]
