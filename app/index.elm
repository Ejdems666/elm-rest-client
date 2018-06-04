-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html

import Html exposing (..)
import Html.Events exposing (onClick)
import Http exposing (emptyBody)
import Json.Decode as Decode
import String exposing (toInt)

main : Program Never Model Msg
main =
  Html.program
    { init = start
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


type alias Model = {
        counter : Int,
        message: String
    }

start : (Model, Cmd Msg)
start = (Model 0 "", Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick SetCount ] [ text "Set" ]
    , div [] [ text (toString model.counter) ]
    , button [ onClick GetCount ] [ text "Get" ]
    , div [] [ text model.message ]
    ]


type Msg
    = GetCount
    | RecieveCount (Result Http.Error Int)
    | SetCount

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetCount ->
        (model, getCounter)
    RecieveCount (Ok newCount) ->
        ( { model | counter = newCount }, Cmd.none)
    RecieveCount (Err errorMessage) ->
        ( { model | message = toString errorMessage }, Cmd.none)
    SetCount ->
        (model, setCounter)



url : String -> String
url action = "http://localhost:3000/counter/" ++ action

getCounter : Cmd Msg
getCounter = Http.send RecieveCount (Http.get (url "") Decode.int)

setCounter : Cmd Msg
setCounter = Http.send RecieveCount (Http.post (url "0") emptyBody Decode.int)