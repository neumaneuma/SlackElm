module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


type alias Message =
    { author : String, time : String, text : String }


sampleChannels : List String
sampleChannels =
    [ "ellie"
    , "elm-dev"
    , "elm-discuss"
    , "elm-format"
    , "elm-ui"
    , "general"
    , "news-and-links"
    ]


sampleActiveChannel : String
sampleActiveChannel =
    "elm-ui"


sampleMessages : List Message
sampleMessages =
    [ { author = "augustin82", time = "6:09AM", text = "@gampleman I think you need to `clip` the `scrollable` element, and that that element should be larger than its parent, which (I think) means that the containing parent should have a fixed width" }
    , { author = "u0421793", time = "6:22AM", text = "I’ve been trying to make a few links on a page in elm and elm-ui but I’ve not found a way to make it work because I haven’t found any examples of elm-ui which incorporate an anchor element" }
    , { author = "augustin82", time = "6:27AM", text = "@u0421793 what are you looking for exactly? do you have an Ellie where you've tried  doing some stuff?" }
    , { author = "icepac", time = "7:53 AM", text = "Anybody replied to @lango https://elmlang.slack.com/archives/C4F9NBLR1/p1541911789377400 About Animation vs Element ?" }
    , { author = "mgriffith", time = "8:00 AM", text = "You can use them together, for sure :smile: You just need to use `Element.htmlAttribute` to render the style attribute." }
    , { author = "duncan", time = "9:32 AM", text = "so ideally, it'd be nice to get the r,g,b,a components from a `Color` so that I could do the string interp (edited)" }
    , { author = "lango", time = "1:23 PM", text = "@mgriffith But that isn't really them 'working together' is it, its more they just happen to be together? For example, `elm-ui` has `background.gradient` but `elm-style-animation` only has `backgroundColor`. It's not clear to me how I could animation `elm-ui`'s `background.gradient` using `elm-animation`?" }
    , { author = "mgriffith", time = "4:28 PM", text = "@lango Oh, yeah I totally agree it isn’t seamless :smile: That’s why I’ve been putting a lot of time towards an API for animation for elm-ui.  But technically `elm-style-animation` and `elm-ui` can work together." }
    , { author = "eniac314", time = "6:49 AM", text = "It seems it it possible to press buttons without the event handler associated being fired when one clicks the thin area along the top border. In this example: https://ellie-app.com/3T4KLBKbnTQa1 it's possible to see the button moving without the counter increasing or decreasing. Is this due to the way I did the styling for the buttons? It seems to be related to the shadow (edited)" }
    , { author = "anthony.deschamps", time = "10:24 AM", text = "What's the most recent version of elm-ui/stylish-elephants that works on 0.18?" }
    , { author = "progger", time = "10:46 AM", text = "I've got some text that I'm laying out in a paragraph, and I want to put a link in there too.  Paragraph put the link on its own line though.  Shouldn't it all flow together?" }
    , { author = "progger", time = "11:22 AM", text = "Ha, I filed an issue about this back in oct.  Used my own workaround!" }
    ]


createChannelPanel : List String -> String -> Element msg
createChannelPanel channels activeChannel =
    column
        [ height fill
        , width <| fillPortion 1
        , paddingXY 0 10
        , Background.color <| rgb255 47 61 78
        , Font.color <| rgb255 255 255 255
        ]
    <|
        List.map (createChannelRow activeChannel) channels

createChannelRow : String -> String -> Element msg
createChannelRow activeChannel channel =
    let
        activeChannelAttrs =
            [ Background.color <| rgb255 97 150 201 ]

        channelAttrs =
            [ paddingXY 15 5, width fill ]
    in
        if channel == activeChannel then
            row ( activeChannelAttrs ++ channelAttrs )
                [ el [ Font.color <| rgb255 198 218 236 ] <| text "# "
                , el [ Font.bold ] <| text channel
                ]
        else
            row channelAttrs
                [ el [ Font.color <| rgb255 140 148 157 ] <| text "# "
                , el [ Font.bold ] <| text channel
                ]

createChatPanel : String -> List Message -> Element msg
createChatPanel activeChannel messages =
    let
        header = createHeader activeChannel
        messagePanel = createMessagePanel messages
        footer = createFooter
    in
        column
            [ height fill
            , width <| fillPortion 5
            -- , explain Debug.todo
            ]
            <| [ header, messagePanel, footer ]

createHeader : String -> Element msg
createHeader activeChannel =
    row
        [ width fill
        , paddingXY 20 5
        , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
        , Border.color <| rgb255 200 200 200
        ]
        [ row [] [text <| "#" ++ activeChannel]
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
        ] <| List.map messageEntry messages


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
        messageTextBoxContainer = createMessageTextBoxContainer
    in
        row
            [ alignBottom
            , padding 20
            , width fill
            -- , explain Debug.todo
            ]
            <| [ messageTextBoxContainer ]

createMessageTextBoxContainer : Element msg
createMessageTextBoxContainer =
    let
        plusSignButton = createPlusSignButton
        messageTextBox = createMessageTextbox
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
            <| [ plusSignButton, messageTextBox ]

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
        channelPanel = createChannelPanel sampleChannels sampleActiveChannel
        chatPanel = createChatPanel sampleActiveChannel sampleMessages
    in
        -- layout [ ] <|
        layout [ height fill ] <|
            row [ height fill, width fill ]
                [ channelPanel
                , chatPanel
                ]

