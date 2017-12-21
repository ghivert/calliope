module Types exposing (..)

import Route

type alias Model =
  { playQueueDisplayed : Bool
  , route : Route.Route
  , songs : List Song
  }

type alias Song =
  {}

setPlayQueueDisplayed : Bool -> Model -> Model
setPlayQueueDisplayed value model =
  { model | playQueueDisplayed = value }

setRoute : Route.Route -> Model -> Model
setRoute route model =
  { model | route = route }

setRouteIn : Model -> Route.Route -> Model
setRouteIn =
  flip setRoute

type Msg
  = TogglePlayQueue
  | AddPlaylist
  | Navigation Route.Route
