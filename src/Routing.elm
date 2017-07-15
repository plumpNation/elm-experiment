module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlayerId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerEditRoute (s "players" </> string)
        , map PlayerAddRoute (s "player")
        , map PlayersRoute (s "players")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

playersListPath : String
playersListPath =
    "#players"


addPlayerPath : String
addPlayerPath =
    "#player"


editPlayerPath : PlayerId -> String
editPlayerPath id =
    "#players/" ++ id
