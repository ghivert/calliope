module Types exposing (..)

type alias Model =
  { playQueueDisplayed : Bool }

setPlayQueueDisplayed : Bool -> Model -> Model
setPlayQueueDisplayed value model =
  { model | playQueueDisplayed = value }

type Msg
  = TogglePlayQueue
