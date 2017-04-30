module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import Routing exposing (parseLocation)
import Commands exposing (savePlayerCmd)
import Models exposing (Model, Player)
import RemoteData

toList remoteData =
    List.map (\item -> item) remoteData

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.FilterPlayers query ->
            ( filterPlayers model query, Cmd.none )

        Msgs.OnFetchPlayers response ->
            ( { model | players = response, originalPlayers = response } , Cmd.none )

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

filterPlayers : Model -> String -> Model
filterPlayers model query =
    let
        matchesQuery player = String.contains query (String.toLower player.name)

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
