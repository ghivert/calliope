module Maybe.Extra.Infix exposing (..)

(>>=) : Maybe a -> (a -> Maybe b) -> Maybe b
(>>=) =
  flip Maybe.andThen

(=<<) : (a -> Maybe b) -> Maybe a -> Maybe b
(=<<) =
  Maybe.andThen
