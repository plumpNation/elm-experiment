module Models exposing (..)

import RemoteData exposing (WebData)
import Debounce exposing (Debounce)

import I18Next exposing
      (Translations
      , initialTranslations
      )

type Route
    = PlayersRoute
    | PlayerEditRoute PlayerId
    | PlayerAddRoute
    | NotFoundRoute


type alias Model =
    { translations: Translations
    , players : WebData (List Player)
    , originalPlayers : WebData (List Player)
    , query : String
    , route : Route
    , debounce : Debounce String
    }


initialModel : Route -> Model
initialModel route =
    { translations = initialTranslations
    , players = RemoteData.Loading
    , originalPlayers = RemoteData.Loading
    , query = ""
    , route = route
    , debounce = Debounce.init
    }

-- Simply gives us more readability when using a player id in other code.
type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }
