module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import SampleMessages exposing (..)


type ChannelStatus
    = Focused
    | UnfocusedRead
    | UnfocusedUnread


type UserStatus
    = Online
    | Offline


type Channel
    = GroupChannel String ChannelStatus
    | UserChannel String ChannelStatus UserStatus


initialGroupChannels : List Channel
initialGroupChannels =
    [ GroupChannel "ellie" UnfocusedRead
    , GroupChannel "elm-dev" UnfocusedRead
    , GroupChannel "elm-discuss" UnfocusedUnread
    , GroupChannel "elm-format" UnfocusedUnread
    , GroupChannel "elm-ui" UnfocusedUnread
    , GroupChannel "general" UnfocusedRead
    , GroupChannel "news-and-links" UnfocusedUnread
    ]

initialUserChannels : List Channel
initialUserChannels =
    [ UserChannel "slackbot" UnfocusedRead Online
    , UserChannel "neumaneuma" UnfocusedRead Online
    , UserChannel "kofi" Focused Online
    , UserChannel "mdgriffith" UnfocusedRead Offline
            ]

activeChannelAttrs : List (Attribute msg)
activeChannelAttrs =
    [ Background.color <| rgb255 97 150 201 ]


channelAttrs : List (Attribute msg)
channelAttrs =
    [ paddingXY 15 5, width fill, spacingXY 10 0 ]


focusedChannelAttrs : List (Attribute msg)
focusedChannelAttrs =
    [ Font.color <| rgb255 198 218 236 ]


unfocusedChannelAttrs : List (Attribute msg)
unfocusedChannelAttrs =
    [ Font.color <| rgb255 140 148 157 ]


createThreadPanel : Element msg
createThreadPanel=
    let
        groupChannelPanel =
            createChannelPanel initialGroupChannels "Channels"

        directMessagesPanel =
            createChannelPanel initialUserChannels "Direct Messages"
    in
    column
        [ height fill
        , width <| fillPortion 1
        , paddingXY 0 10
        , Background.color <| rgb255 47 61 78
        , Font.color <| rgb255 255 255 255
        , Font.size 15
        , spacingXY 0 20

        -- , explain Debug.todo
        ]
        [ groupChannelPanel
        , directMessagesPanel
        ]


createChannelPanel : List Channel -> String -> Element msg
createChannelPanel channels headerName =
    let
        channelRowList =
            List.map createChannelRow channels

        headerRow =
            row
                [ paddingXY 15 5, width fill, Font.hairline ]
                [ text headerName ]
    in
    column
        [ width fill

        -- , explain Debug.todo
        ]
        (headerRow :: channelRowList)


createChannelRow : Channel -> Element msg
createChannelRow channel =
    case channel of
        UserChannel name channelStatus userStatus ->
            createUserChannel name channelStatus userStatus

        GroupChannel name status ->
            createGroupChannel name status


createGroupChannel : String -> ChannelStatus -> Element msg
createGroupChannel name status =
    case status of
        Focused ->
            row (activeChannelAttrs ++ channelAttrs)
                [ el focusedChannelAttrs <| text "# "
                , el [ Font.hairline ] <| text name
                ]

        UnfocusedRead ->
            row channelAttrs
                [ el unfocusedChannelAttrs <| text "# "
                , el [ Font.hairline ] <| text name
                ]

        UnfocusedUnread ->
            row channelAttrs
                [ el unfocusedChannelAttrs <| text "# "
                , el [ Font.semiBold ] <| text name
                ]


createUserChannel : String -> ChannelStatus -> UserStatus -> Element msg
createUserChannel name channelStatus userStatus =
    let
        userStatusImage =
            createUserStatusImage userStatus
    in
    case channelStatus of
        Focused ->
            row (activeChannelAttrs ++ channelAttrs)
                [ el focusedChannelAttrs userStatusImage
                , el [ Font.hairline ] <| text name
                ]

        UnfocusedRead ->
            row channelAttrs
                [ el unfocusedChannelAttrs userStatusImage
                , el [ Font.semiBold ] <| text name
                ]

        UnfocusedUnread ->
            row channelAttrs
                [ el unfocusedChannelAttrs userStatusImage
                , el [ Font.semiBold ] <| text name
                ]


createUserStatusImage : UserStatus -> Element msg
createUserStatusImage userStatus =
    case userStatus of
        Online ->
            image [] { src = "../img/onlineStatus.png", description = "status: online" }

        Offline ->
            image [] { src = "../img/offlineStatus.png", description = "status: offline" }


-- createDirectMessages : List String -> String -> Element msg
-- createDirectMessages channels activeChannel =
--     let
--         channelRowList =
--             List.map (createDirectMessageRow activeChannel) channels

--         headerRow =
--             row
--                 [ paddingXY 15 5, width fill, Font.extraLight ]
--                 [ text "Direct Messages" ]
--     in
--     column
--         [ width fill

--         -- , explain Debug.todo
--         ]
--         (headerRow :: channelRowList)


-- createDirectMessageRow : String -> String -> Element msg
-- createDirectMessageRow activeChannel channel =
--     if channel == activeChannel then
--         row (activeChannelAttrs ++ channelAttrs)
--             [ el [ Font.color <| rgb255 198 218 236 ] <|
--                 image [] { src = "../img/onlineStatus.png", description = "status: online" }
--             , el [ Font.semiBold ] <|
--                 text channel
--             ]

--     else
--         row channelAttrs
--             [ el [ Font.color <| rgb255 198 218 236 ] <|
--                 image [] { src = "../img/offlineStatus.png", description = "status: offline" }
--             , el [ Font.semiBold ] <|
--                 text channel
--             ]


createChatPanel : String -> List Message -> Element msg
createChatPanel channelName messages =
    let
        header =
            createHeader channelName

        messagePanel =
            createMessagePanel messages

        footer =
            createFooter
    in
    column
        [ height fill
        , width <| fillPortion 5

        -- , explain Debug.todo
        ]
    <|
        [ header, messagePanel, footer ]


createHeader : String -> Element msg
createHeader channelName =
    row
        [ width fill
        , paddingXY 20 5
        , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
        , Border.color <| rgb255 200 200 200
        ]
        [ row [] [ text <| "#" ++ channelName ]
        , Input.button
            [ padding 5
            , alignRight
            , Border.width 1
            , Border.rounded 3
            , Border.color <| rgb255 200 200 200
            ]
            { onPress = Nothing
            , label = text "Search"
            }
        ]


createMessagePanel : List Message -> Element msg
createMessagePanel messages =
    column
        [ padding 10
        , spacingXY 0 20
        , scrollbarY
        ]
    <|
        List.map messageEntry messages


messageEntry : Message -> Element msg
messageEntry message =
    column [ width fill, spacingXY 0 5 ]
        [ row [ spacingXY 10 0 ]
            [ el [ Font.bold ] <| text message.author, text message.time ]
        , paragraph [] [ text message.text ]
        ]


createFooter : Element msg
createFooter =
    let
        messageTextBoxContainer =
            createMessageTextBoxContainer
    in
    row
        [ alignBottom
        , padding 20
        , width fill

        -- , explain Debug.todo
        ]
    <|
        [ messageTextBoxContainer ]


createMessageTextBoxContainer : Element msg
createMessageTextBoxContainer =
    let
        plusSignButton =
            createPlusSignButton

        messageTextBox =
            createMessageTextbox
    in
    row
        [ spacingXY 2 0
        , width fill
        , alignLeft
        , alignBottom
        , Border.width 2
        , Border.rounded 8
        , Border.color <| rgb255 200 200 200

        -- , explain Debug.todo
        ]
    <|
        [ plusSignButton, messageTextBox ]


createPlusSignButton : Element msg
createPlusSignButton =
    row
        [ padding 15
        , Border.widthEach { right = 2, left = 0, top = 0, bottom = 0 }
        , Border.color <| rgb255 200 200 200
        , mouseOver [ Background.color <| rgb255 52 188 141, Font.color <| rgb255 255 255 255 ]
        , alignLeft
        ]
        [ text "+" ]


createMessageTextbox : Element msg
createMessageTextbox =
    row
        [ mouseOver [ Background.color <| rgb255 100 282 44 ]
        ]
        []


main : Html msg
main =
    let
        threadPanel =
            createThreadPanel 

        chatPanel =
            createChatPanel "kofi" sampleChannelMessages
    in
    -- layout [ ] <|
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ threadPanel
            , chatPanel
            ]
