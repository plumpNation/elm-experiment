module View.Player.Add exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Routing exposing (playersListPath)

view : Html Msg
view =
    div []
        [ nav
        , form
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : Html Msg
form =
    div [ class "m3" ]
        [ h1 [] [ text "Add player" ]
        , input [] []
        ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href playersListPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
