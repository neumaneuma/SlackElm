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
    case msg of
        ReadMsg channel ->
            -- channel becomes Focused
            ( { model | text = Debug.log "ReadMsg: " "RecvMsg" }, Cmd.none )

        RecvMsg channel ->
            -- chat panel becomes populated with messages from the server
            ( { model | text = Debug.log "RecvMsg: " "RecvMsg" }, Cmd.none )

        SendMsg channel ->
            -- chat message sent to server
            ( { model | text = Debug.log "SendMsg: " "SendMsg" }, Cmd.none )

        NewUserChannel channel ->
            -- new channel added to user channels
            ( { model | text = Debug.log "NewUserChannel: " "NewUserChannel" }, Cmd.none )

        NewGroupChannel channel ->
            -- new channel added to group channels
            ( { model | text = Debug.log "NewGroupChannel: " "NewGroupChannel" }, Cmd.none )



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
