module Task.Extra.Infix exposing (..)

import Task exposing (Task)

(*>) : Task x a -> Task x b -> Task x b
(*>) task1 task2 =
  Task.andThen (\_ -> task2) task1
