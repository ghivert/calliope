module Renderer exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Rocket exposing ((=>))
import Update.Extra as Update
import Types exposing (..)
import View.Navbar
import View.Main

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
  { playQueueDisplayed = False } ! []

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({ playQueueDisplayed } as model) =
  case msg of
    TogglePlayQueue ->
      model
        |> setPlayQueueDisplayed (not playQueueDisplayed)
        |> Update.identity
    AddPlaylist ->
      model ! []

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  Html.div
    [ Html.Attributes.class "layout" ]
    [ View.Navbar.view model
    , mainView model
    , readingView model
    , playQueueView model
    ]

mainView : Model -> Html Msg
mainView ({ playQueueDisplayed } as model) =
  Html.div
    [ Html.Attributes.classList
      [ "full white main-panel" => True
      , "til-the-end" => not playQueueDisplayed
      ]
    ]
    [ View.Main.view model ]

readingView : Model -> Html Msg
readingView { playQueueDisplayed } =
  Html.div
    [ Html.Attributes.classList
      [ "full light-grey reading-panel" => True
      , "til-the-end" => not playQueueDisplayed
      ]
    ]
    []

playQueueView : Model -> Html Msg
playQueueView { playQueueDisplayed } =
  if playQueueDisplayed then
    Html.div [ Html.Attributes.class "full blue play-queue-panel" ] []
  else
    Html.text ""
