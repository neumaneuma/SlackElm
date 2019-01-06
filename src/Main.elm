module Main exposing (main)

import Html exposing (Html)
import UI exposing (..)
import SampleMessages exposing (..)
import Element exposing (..)

main : Html msg
main =
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
