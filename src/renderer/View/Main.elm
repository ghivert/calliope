module View.Main exposing (view)

import Html exposing (Html)
import Html.Attributes
import Html.Extra
import Types exposing (..)

view : Model -> Html Msg
view model =
  Html.div []
    [ header model
    , featured model
    , Html.Extra.separator
    ]

header : Model -> Html Msg
header model =
  Html.div
    [ Html.Attributes.class "header" ]
    [ searchField model
    , profileIcon model
    ]

searchField : Model -> Html Msg
searchField model =
  Html.span
    [ Html.Attributes.class "omnisearch" ]
    [ Html.input
      [ Html.Attributes.type_ "text"
      , Html.Attributes.placeholder "Search"
      ]
      []
    ]

profileIcon : Model -> Html Msg
profileIcon model =
  Html.div
    [ Html.Attributes.class "flex align-center cursor-pointer" ]
    [ Html.i
      [ Html.Attributes.class "fa fa-angle-down padding-horizontal-medium" ]
      []
    , Html.span
      [ Html.Attributes.class "profile-name" ]
      [ Html.text "Guillaume Hivert" ]
    , Html.img
      [ Html.Attributes.src "images/portrait.jpg"
      , Html.Attributes.class "profile-picture"
      ]
      []
    ]

featured : Model -> Html Msg
featured model =
  Html.div
    [ Html.Attributes.class "featured" ]
    [ Html.h2 [] [ Html.text "Featured" ]
    , Html.h1 [] [ Html.text "Albums" ]
    , Html.div
      [ Html.Attributes.class "row" ]
      coverFeaturedAlbums
    ]

type alias Url =
  String

type alias Album =
  { cover : Url
  , title : String
  , group : String
  }

muse : Album
muse =
  Album
    "images/muse-cover.jpg"
    "Drones"
    "Muse"

spiritualized : Album
spiritualized =
  Album
    "images/spiritualized-cover.jpg"
    "Ladies and Gentlemen we are floating in space"
    "Spiritualized"

tryo : Album
tryo =
  Album
    "images/tryo-cover.jpg"
    "C'est déjà ça"
    "Tryo"

zedd : Album
zedd =
  Album
    "images/zedd-cover.jpg"
    "Beautiful Days"
    "Zedd"

circa : Album
circa =
  Album
    "images/circa-cover.jpg"
    "On Letting Go"
    "Circa Survive"

coverFeaturedAlbums : List (Html Msg)
coverFeaturedAlbums =
  [ muse
  , spiritualized
  , tryo
  , zedd
  , circa
  ]
    |> List.map toCoverAlbum

toCoverAlbum : Album -> Html Msg
toCoverAlbum { cover, title, group } =
  coverAlbum cover title group

coverAlbum : Url -> String -> String -> Html Msg
coverAlbum url albumName groupName =
  Html.div
    [ Html.Attributes.class "cover-featured-album" ]
    [ Html.img [ Html.Attributes.src url ] []
    , Html.h3 [] [ Html.text albumName ]
    , Html.h4 [] [ Html.text groupName ]
    ]
