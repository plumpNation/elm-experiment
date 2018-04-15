module View.Player.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, type_)
import Html.Events exposing (onInput, onClick)
import Msgs exposing (Msg)
import Models exposing (Model, Player)
import RemoteData exposing (WebData)
import Routing exposing (editPlayerPath, addPlayerPath)
import I18Next exposing (t, Translations)

view : Model -> Html Msg
view model =
    div []
        [ nav
        , addPlayerBtn
        , filter
        , maybeList model.translations model.players
        ]

maybeList : Translations -> WebData (List Player) -> Html Msg
maybeList translations players =
    case players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text (t translations "Loading...")

        RemoteData.Success players ->
            list translations players

        RemoteData.Failure error ->
            text (toString error)


filter : Html Msg
filter =
    div [ class "filter-container" ]
        [ input [ type_ "text", class "input", onInput Msgs.DebounceFilterPlayers ] []
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]


list : Translations -> List Player -> Html Msg
list translations players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text (t translations "Name") ]
                    , th [] [ text (t translations "Level") ]
                    , th [] [ text (t translations "Actions") ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text (toString player.id) ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ editPlayerBtn player
            , deletePlayerBtn player ]
        ]


addPlayerBtn : Html.Html Msg
addPlayerBtn =
    let
        path = addPlayerPath
    in
        a [ class "btn regular", href path ]
            [ i [ class "fa fa-plus mr1" ] []
            , span [] [ text "Add player" ]
            ]


deletePlayerBtn : Player -> Html.Html Msg
deletePlayerBtn player =
    let
        message =
            Msgs.DeletePlayer player
    in
        button [ class "btn regular", onClick message ]
            [ i [ class "fa fa-trash mr1" ] []
            , span [] [ text "Delete" ]
            ]


editPlayerBtn : Player -> Html.Html Msg
editPlayerBtn player =
    let
        path = editPlayerPath player.id
    in
        a [ class "btn regular", href path ]
            [ i [ class "fa fa-pencil mr1" ] []
            , span [] [ text "Edit" ]
            ]
