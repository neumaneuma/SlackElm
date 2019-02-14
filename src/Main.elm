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


initializeChannel : ChannelMetadata -> Channel
initializeChannel channelMetadata =
    case channelMetadata of
        UserChannel "kofi" _ _ ->
            Channel channelMetadata sampleMessages

        _ ->
            Channel channelMetadata []


init : () -> ( Model, Cmd Msg )
init _ =
    let
        model =
            List.map initializeChannel (initialGroupChannels ++ initialUserChannels)
    in
    ( model, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReadMsg channel ->
            -- channel becomes Focused
            let
                text =
                    Debug.log "ReadMsg: " "ReadMsg"
            in
            ( model, Cmd.none )

        RecvMsg channel ->
            -- chat panel becomes populated with messages from the server
            let
                text =
                    Debug.log "RecvMsg: " "RecvMsg"
            in
            ( model, Cmd.none )

        SendMsg channel ->
            -- chat message sent to server
            let
                text =
                    Debug.log "SendMsg: " "SendMsg"
            in
            ( model, Cmd.none )

        NewUserChannel channel ->
            -- new channel added to user channels
            let
                text =
                    Debug.log "NewUserChannel: " "NewUserChannel"
            in
            ( model, Cmd.none )

        NewGroupChannel channel ->
            -- new channel added to group channels
            let
                text =
                    Debug.log "NewGroupChannel: " "NewGroupChannel"
            in
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        channelPanel =
            createChannelPanelContainer model

        chatPanel =
            createChatPanel <| Channel slackBotChannel sampleMessages
    in
    -- layout [ ] <|
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ channelPanel
            , chatPanel
            ]
