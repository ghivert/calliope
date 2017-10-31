module Renderer exposing (..)

import Html exposing (Html)
import Html.Attributes
-- import Html.Events
import Types exposing (..)
import Navbar

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

init : (Model, Cmd Msg)
init =
  0 ! []

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  model ! []

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  Html.div
    [ Html.Attributes.class "layout" ]
    [ Navbar.view model
    , mainView model
    , readingView model
    , playQueueView model
    ]

mainView : Model -> Html Msg
mainView model =
  Html.div [] []

readingView : Model -> Html Msg
readingView model =
  Html.div [] []

playQueueView : Model -> Html Msg
playQueueView model =
  Html.div [] []
