module Main exposing (main)

import Html exposing (Html)
import UI exposing (..)
import SampleMessages exposing (..)
import Element exposing (..)
import Browser
import Html exposing (Html, text, pre)
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




init : () -> (Model, Cmd Msg)
init _ =
    (ReadMsg slackBotChannel, Cmd.none)

-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotText result ->
      case result of
        Ok fullText ->
          (Success fullText, Cmd.none)

        Err _ ->
          (Failure, Cmd.none)



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