module View.Player.Add exposing (..)

import Html exposing (..)
import Models exposing (Model)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Routing exposing (playersListPath)
import I18Next exposing (t, Translations)


view : Model -> Html Msg
view model =
    div []
        [ nav model.translations
        , form model.translations
        ]


nav : Translations -> Html Msg
nav translations =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn translations ]


form : Translations -> Html Msg
form translations =
    div [ class "m3" ]
        [ h1 [] [ text (t translations "Add player") ]
        , input [] []
        ]


listBtn : Translations -> Html Msg
listBtn translations =
    a
        [ class "btn regular"
        , href playersListPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text (t translations "List") ]
