module Msgs exposing (..)

import Http
import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Debounce exposing (Debounce)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
    | FilterPlayers String
    | DebounceFilterPlayers String
    | DebounceMsg Debounce.Msg
