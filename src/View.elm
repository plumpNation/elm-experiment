module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, PlayerId)
import Msgs exposing (Msg)
import View.Player.Edit
import View.Player.List
import View.Player.Add
import RemoteData

import I18Next exposing (t, Translations)


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            View.Player.List.view model

        Models.PlayerEditRoute id ->
            playerEditPage model id

        Models.PlayerAddRoute ->
            playerAddPage model

        Models.NotFoundRoute ->
            notFoundView model


playerAddPage : Model -> Html Msg
playerAddPage model =
    View.Player.Add.view model


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text (t model.translations "Loading ...")

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head

            in
                case maybePlayer of
                    Just player ->
                        View.Player.Edit.view model player

                    Nothing ->
                        notFoundView model

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Model -> Html Msg
notFoundView model =
    div []
        [ text (t model.translations "NOT_FOUND")
        ]
