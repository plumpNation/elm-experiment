module Models exposing (..)
import RemoteData exposing (WebData)


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


type alias Model =
    { players : WebData (List Player)
    , originalPlayers : WebData (List Player)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , originalPlayers = RemoteData.Loading
    , route = route
    }

-- Simply gives us more readability when using a player id in other code.
type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }
