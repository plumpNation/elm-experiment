module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlayerId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        , map PlayersRoute (s "player")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

playersPath : String
playersPath =
    "#players"


addPlayerPath : String
addPlayerPath =
    "#player"


editPlayerPath : PlayerId -> String
editPlayerPath id =
    "#players/" ++ id
