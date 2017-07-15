module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, PlayerId)
import Models exposing (Model)
import Msgs exposing (Msg)
import View.Player.Edit
import View.Player.List
import View.Player.Add
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            View.Player.List.view model.players

        Models.PlayerEditRoute id ->
            playerEditPage model id

        Models.PlayerAddRoute ->
            playerAddPage

        Models.NotFoundRoute ->
            notFoundView


playerAddPage : Html Msg
playerAddPage =
    View.Player.Add.view


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        View.Player.Edit.view player

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
