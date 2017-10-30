module MainProcess exposing (..)

import Electron

main =
  Electron.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    }
