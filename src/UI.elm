module UI exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input

type Msg
  = ReadMsg Channel -- channel becomes Focused
  | RecvMsg Channel -- chat panel becomes populated with messages from the server
  | SendMsg Channel -- chat message sent to server
  | NewUserChannel Channel -- new channel added to user channels
  | NewGroupChannel Channel -- new channel added to group channels

type alias Model =
    { author : String, time : String, text : String }


type UnfocusedUnread
    = WithNotification
    | WithoutNotification


type ChannelStatus
    = Focused
    | UnfocusedRead
    | UnfocusedUnread UnfocusedUnread


type UserStatus
    = Online
    | Offline


type Channel
    = GroupChannel String ChannelStatus
    | UserChannel String ChannelStatus UserStatus

slackBotChannel : Channel
slackBotChannel =
    UserChannel "slackbot" UnfocusedRead Online

initialGroupChannels : List Channel
initialGroupChannels =
    [ GroupChannel "ellie" UnfocusedRead
    , GroupChannel "elm-dev" UnfocusedRead
    , GroupChannel "elm-discuss" <| UnfocusedUnread WithNotification
    , GroupChannel "elm-format" <| UnfocusedUnread WithoutNotification
    , GroupChannel "elm-ui" <| UnfocusedUnread WithoutNotification
    , GroupChannel "general" UnfocusedRead
    , GroupChannel "news-and-links" <| UnfocusedUnread WithoutNotification
    ]


initialUserChannels : List Channel
initialUserChannels =
    [ slackBotChannel
    , UserChannel "neumaneuma" UnfocusedRead Online
    , UserChannel "randomUser1" UnfocusedRead Offline
    , UserChannel "randomUser2" (UnfocusedUnread WithNotification) Online
    , UserChannel "randomUser3" (UnfocusedUnread WithoutNotification) Offline
    , UserChannel "randomUser4" (UnfocusedUnread WithNotification) Offline
    , UserChannel "randomUser5" (UnfocusedUnread WithoutNotification) Online
    , UserChannel "kofi" Focused Online
    ]


activeChannelAttrs : List (Attribute Msg)
activeChannelAttrs =
    [ Background.color <| rgb255 97 150 201 ]


channelAttrs : List (Attribute Msg)
channelAttrs =
    [ paddingXY 15 5, width fill, spacingXY 10 0, onClick <| ReadMsg <| UserChannel "kofi" Focused Online]


focusedChannelAttrs : List (Attribute Msg)
focusedChannelAttrs =
    [ Font.color <| rgb255 198 218 236 ]


unfocusedChannelAttrs : List (Attribute Msg)
unfocusedChannelAttrs =
    [ Font.color <| rgb255 140 148 157 ]



-- This name is horrible... not sure how to name effectively here


createChannelPanelContainer : Element Msg
createChannelPanelContainer =
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


createChannelPanel : List Channel -> String -> Element Msg
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


createChannelRow : Channel -> Element Msg
createChannelRow channel =
    case channel of
        UserChannel name channelStatus userStatus ->
            createChannelRowHelper name channelStatus <|
                createUserStatusImage userStatus

        GroupChannel name status ->
            createChannelRowHelper name status <|
                text "# "



-- Not thrilled about this name...


createChannelRowHelper : String -> ChannelStatus -> Element Msg -> Element Msg
createChannelRowHelper name status channelSymbol =
    case status of
        Focused ->
            row (activeChannelAttrs ++ channelAttrs)
                [ el focusedChannelAttrs channelSymbol
                , el [ Font.hairline ] <| text name
                ]

        UnfocusedRead ->
            row channelAttrs
                [ el unfocusedChannelAttrs channelSymbol
                , el [ Font.hairline ] <| text name
                ]

        UnfocusedUnread WithNotification ->
            row channelAttrs
                [ el unfocusedChannelAttrs channelSymbol
                , el [ Font.semiBold ] <| text name
                , image [ alignRight ] { src = "../img/unreadChat.png", description = "unread messages" }
                ]

        UnfocusedUnread WithoutNotification ->
            row channelAttrs
                [ el unfocusedChannelAttrs channelSymbol
                , el [ Font.semiBold ] <| text name
                ]


createUserStatusImage : UserStatus -> Element Msg
createUserStatusImage userStatus =
    case userStatus of
        Online ->
            image [] { src = "../img/onlineStatus.png", description = "status: online" }

        Offline ->
            image [] { src = "../img/offlineStatus.png", description = "status: offline" }


createChatPanel : String -> List Model -> Element Msg
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


createHeader : String -> Element Msg
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


createMessagePanel : List Model -> Element Msg
createMessagePanel messages =
    column
        [ padding 10
        , spacingXY 0 20
        , scrollbarY
        ]
    <|
        List.map messageEntry messages


messageEntry : Model -> Element Msg
messageEntry message =
    column [ width fill, spacingXY 0 5 ]
        [ row [ spacingXY 10 0 ]
            [ el [ Font.bold ] <| text message.author, text message.time ]
        , paragraph [] [ text message.text ]
        ]


createFooter : Element Msg
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


createMessageTextBoxContainer : Element Msg
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


createPlusSignButton : Element Msg
createPlusSignButton =
    row
        [ padding 15
        , Border.widthEach { right = 2, left = 0, top = 0, bottom = 0 }
        , Border.color <| rgb255 200 200 200
        , mouseOver [ Background.color <| rgb255 52 188 141, Font.color <| rgb255 255 255 255 ]
        , alignLeft
        ]
        [ text "+" ]


createMessageTextbox : Element Msg
createMessageTextbox =
    row
        [ mouseOver [ Background.color <| rgb255 100 282 44 ]
        ]
        []