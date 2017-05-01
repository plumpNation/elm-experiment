module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import Routing exposing (parseLocation)
import Commands exposing (savePlayerCmd)
import Models exposing (Model, Player)
import RemoteData
import Debounce exposing (Debounce)
import Time
import Task

toList remoteData =
    List.map (\item -> item) remoteData

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.DebounceFilterPlayers query ->
            let
                (debounce, cmd) =
                    Debounce.push debounceConfig query model.debounce
            in
                ( { model
                  | query = query
                  , debounce = debounce
                  }, cmd )

        Msgs.FilterPlayers query ->
            ( filterPlayers model query, Cmd.none )

        -- This is where commands are actually sent.
        -- The logic can be dependent on the current model.
        -- You can also use all the accumulated values.
        Msgs.DebounceMsg msg ->
            let
                (debounce, cmd) =
                    Debounce.update debounceConfig (Debounce.takeLast sendFilterPlayers) msg model.debounce
            in
                ( { model | debounce = debounce }, cmd )

        Msgs.OnFetchPlayers response ->
            ( { model
              | players = response
              , originalPlayers = response
              } , Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )

-- This defines how the debouncer should work.
-- Choose the strategy for your use case.
debounceConfig : Debounce.Config Msg
debounceConfig =
    { strategy = Debounce.later (0.5 * Time.second)
    , transform = Msgs.DebounceMsg
    }


sendFilterPlayers : String -> Cmd Msg
sendFilterPlayers s =
    Task.perform Msgs.FilterPlayers (Task.succeed s)


filterPlayers : Model -> String -> Model
filterPlayers model query =
    let
        matchesQuery player = String.contains (String.toLower query) (String.toLower player.name)

        filterPlayerList players =
            List.filter matchesQuery players

        filteredPlayers =
            RemoteData.map filterPlayerList model.originalPlayers

    in
        { model | players = filteredPlayers }


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
