port module Content exposing (Content)

import Html exposing (section, text)
import Html.Attributes exposing (class)

port doit : String -> Cmd msg

main =
  section [class "content"] [text "I am content"]
