module Main exposing (..)

import Html exposing (Html, ul, li, text, program)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { tweets: List String }


init : ( Model, Cmd Msg )
init =
    ( {
        tweets =
            [ "This is a tweet"
            , "This is another tweet"
            , "This is a tweet"
            , "This is a tweet" ]
    }, Cmd.none )



-- MESSAGES


type Msg
    = Loaded



-- VIEW
renderTweet : String -> Html Msg
renderTweet tweet =
    li [] [text tweet]

view : Model -> Html Msg
view model =
    ul [] (List.map renderTweet model.tweets)



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Loaded ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
