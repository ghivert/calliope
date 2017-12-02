module View.Main exposing (view)

import Html exposing (Html)
import Html.Attributes
import Html.Extra
import Time exposing (Time)
import Rocket exposing ((=>))
import Types exposing (..)

view : Model -> Html Msg
view model =
  Html.div []
    [ header model
    , featured model
    , Html.Extra.separator
    , playlists model
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
  , tryo
  , circa
  , zedd
  , spiritualized
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

playlists : Model -> Html Msg
playlists model =
  Html.div
    [ Html.Attributes.class "playlists" ]
    [ Html.h2 [] [ Html.text "Playlists" ]
    , Html.h1 [] [ Html.text "Recently Added" ]
    , playlistContent model
    ]

playlistExample : List Song
playlistExample =
  [ "Dead Inside"
  , "[Drill Sergeant]"
  , "Psycho"
  , "Mercy"
  , "Reapers"
  , "The Handler"
  , "[JFK]"
  , "Defector"
  , "Revolt"
  , "Aftermath"
  , "The Globalist"
  , "Drones"
  ]
    |> List.map toMuseAlbum

toMuseAlbum : String -> Song
toMuseAlbum title =
  Song title "Drones" "Muse" "images/muse-cover.jpg" Nothing

playlistContent : Model -> Html Msg
playlistContent model =
  Html.div
    [ Html.Attributes.class "playlist-content"
    , Html.Attributes.style
      [ "grid-template-columns" => "repeat(6, minmax(50px, 1fr))" ]
    ]
    <| List.concat
      [ headerPlaylistContent model
      , List.concatMap toPlaylistTrack playlistExample
      ]

headerPlaylistContent : Model -> List (Html Msg)
headerPlaylistContent model =
  [ Html.div [] [] -- First case of the grid : empty.
  , Html.h2 [] [ Html.text "Title" ]
  , Html.h2 [] [ Html.text "Artist" ]
  , Html.h2 [] [ Html.text "Album" ]
  , Html.h2 [] [ Html.text "Added" ]
  , Html.h2 [] [ Html.text "Duration" ]
  ]

type alias Song =
  { title : String
  , album : String
  , artist : String
  , cover : Url
  , duration : Maybe Time
  }

toPlaylistTrack : Song -> List (Html Msg)
toPlaylistTrack { title, album, artist, cover, duration } =
  [ Html.img [ Html.Attributes.src cover ] []
  , Html.text title
  , Html.text artist
  , Html.text album
  , Html.text ""
  , Html.text <| toString duration
  ]
    |> List.map (Html.div [] << List.singleton)
