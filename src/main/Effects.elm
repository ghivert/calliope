effect module Effects where { command = MyCmd, subscription = MySub } exposing (..)

import Color exposing (Color)
import Task exposing (Task)
import Native.BrowserWindow

type Electron = Electron

type alias BrowserWindow =
  { url : String
  , width : Maybe Int
  , height : Maybe Int
  , backgroundColor : Maybe Color
  , coordinates : Maybe { x : Int, y : Int }
  , show : Maybe Bool
  }

cmdMap : (a -> b) -> MyCmd a -> MyCmd b
cmdMap _ myCmd =
  case myCmd of
    NewBrowserWindow x ->
      NewBrowserWindow x
      |> Debug.log "cmdMap"

type MySub msg =
  Monitor (Electron -> msg)

type MyCmd msg =
  NewBrowserWindow BrowserWindow

newBrowserWindow : BrowserWindow -> Cmd msg
newBrowserWindow browserWindow =
  command (NewBrowserWindow browserWindow)

subMap : (a -> b) -> MySub a -> MySub b
subMap func (Monitor tagger) =
  Monitor (tagger >> func)

type alias State msg =
  { subs : List (MySub msg)}

init : Task x (State msg)
init =
  Task.succeed (State [])

onSelfMsg : Platform.Router msg Electron -> Electron -> State msg -> Task Never (State msg)
onSelfMsg router location state =
  Debug.log "onSelfMsg" <|
    notify router state.subs location
      &> Task.succeed state

(&>) : Task x a -> Task x b -> Task x b
(&>) task1 task2 =
  Task.andThen (\_ -> task2) task1

notify : Platform.Router msg Electron -> List (MySub msg) -> Electron -> Task x ()
notify router subs location =
  let
    send (Monitor tagger) =
      Platform.sendToApp router (tagger location)
      |> Debug.log "sendToApp"
  in
    Task.sequence (List.map send subs)
      &> Task.succeed ()
      |> Debug.log "notify"


onEffects : Platform.Router msg Electron -> List (MyCmd msg) -> List (MySub msg) -> State msg -> Task Never (State msg)
onEffects router cmds subs state =
  -- let
  --   stepState =
  --     case (subs, popWatcher) of
  --       ([], Just watcher) ->
  --         killPopWatcher watcher
  --           &> Task.succeed (State subs Nothing)
  --
  --       (_ :: _, Nothing) ->
  --         Task.map (State subs << Just) (spawnPopWatcher router)
  --
  --       (_, _) ->
  --         Task.succeed (State subs popWatcher)
  --
  -- in
    Task.sequence (List.map (cmdHelp router subs) cmds)
      &> Task.succeed state
      |> Debug.log "onEffects"

cmdHelp : Platform.Router msg Electron -> List (MySub msg) -> MyCmd msg -> Task Never ()
cmdHelp router subs cmd =
  case cmd of
    NewBrowserWindow x ->
      create x

create : BrowserWindow -> Task Never ()
create =
  Native.BrowserWindow.create
