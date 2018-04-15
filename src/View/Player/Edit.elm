module View.Player.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)
import Models exposing (Model, Player)
import Routing exposing (playersListPath)
import I18Next exposing (t, Translations)


view : Model -> Player -> Html Msg
view model player =
    div []
        [ nav model.translations player
        , form model.translations player
        ]


nav : Translations -> Player -> Html Msg
nav translations model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn translations ]


form : Translations -> Player -> Html Msg
form translations player =
    div [ class "m3" ]
        [ h1 [] [ text player.name ]
        , formLevel translations player
        ]


formLevel : Translations -> Player -> Html Msg
formLevel translations player =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text (t translations "Level") ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    let
        message =
            Msgs.ChangeLevel player -1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    let
        message =
            Msgs.ChangeLevel player 1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-plus-circle" ] [] ]


listBtn : Translations -> Html Msg
listBtn translations =
    a [ class "btn regular"
        , href playersListPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] []
            , text (t translations "List")
            ]
