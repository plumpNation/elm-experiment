import Html exposing (Html, ul, li, text, beginnerProgram)

-- MODEL


type alias Model =
    { tweets: List String }


model : Model
model = {
    tweets =
        [ "This is a tweet"
        , "This is another tweet"
        , "This is a tweet"
        , "This is a tweet" ] }



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


update : Msg -> Model -> Model
update msg model =
    case msg of
        Loaded ->
            model

-- MAIN


main =
    beginnerProgram
        { model = model
        , view = view
        , update = update
        }
