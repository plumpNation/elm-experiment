module Models exposing (..)
import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    }


initialModel : Model
initialModel =
    { players = RemoteData.Loading
    }


-- Simply gives us more readability when using a player id in other code.
type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }
