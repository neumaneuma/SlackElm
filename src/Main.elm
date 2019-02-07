module Main exposing (main)

import Browser
import Element exposing (..)
import Html exposing (Html, pre, text)
import SampleMessages exposing (..)
import UI exposing (..)



-- import Http
-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


init : () -> ( Model, Cmd Msg )
init _ =
    ( { author = "author", time = "6:27AM", text = "test" }, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- case msg of
--   ReadMsg channel ->-- channel becomes Focused
-- case channel of
--     GroupChannel name status ->
-- | RecvMsg Channel -- chat panel becomes populated with messages from the server
-- | SendMsg Channel -- chat message sent to server
-- | NewUserChannel Channel -- new channel added to user channels
-- | NewGroupChannel Channel -- new channel added to group channels
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        channelPanel =
            createChannelPanelContainer

        chatPanel =
            createChatPanel "kofi" sampleMessages
    in
    -- layout [ ] <|
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ channelPanel
            , chatPanel
            ]
