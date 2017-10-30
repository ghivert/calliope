module MainProcess exposing (..)

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
    [ Electron.BrowserWindow.open "index.html"
      [ ("width", "100px")
      , ("height", "100px")
      , ("show", "false")
      ]
    ]

update : a -> b -> ( b, Cmd msg )
update msg model =
  model ! []

subscriptions : a -> Sub msg
subscriptions model =
  Sub.none
