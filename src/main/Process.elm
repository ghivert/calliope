module Process exposing (..)

import Electron
import Electron.BrowserWindow

type alias Model = Int

main : Program Never Model msg
main =
  Electron.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    }

init : (Model, Cmd msg)
init =
  0 !
    [ Electron.BrowserWindow.open "file:///Users/doctor/Workspace/debussy/src/static/index.html"
      [ ("width", "1000")
      , ("height", "700")
      , ("show", "true")
      -- , ("transparent", "true")
      -- , ("frame", "false")
      -- , ("titleBarStyle", "hiddenInset")
      , ("vibrancy", "selection")
      ]
    ]
-- appearance-based, light, dark, titlebar, selection, menu, popover, sidebar, medium-light or ultra-dark
update : a -> b -> ( b, Cmd msg )
update msg model =
  model ! []

subscriptions : a -> Sub msg
subscriptions model =
  Sub.none
