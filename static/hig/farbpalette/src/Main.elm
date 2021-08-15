module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


init : Model
init =
    { hoveringColor = Nothing
    , clicked = False
    }



-- MODEL


type alias Model =
    { hoveringColor : Maybe String
    , clicked : Bool
    }


type Msg
    = HoverColor String
    | CopyColor
    | LeaveElement


farben : List (List String)
farben =
    [ [ "#a20967", "#cb0b81", "#e93a9a", "#ff5bb6", "#ff7cc5" ]
    , [ "#99002e", "#bf0039", "#e93d58", "#ff6c7f", "#ff8999" ]
    , [ "#a43e1e", "#cd4d25", "#e9643a", "#ff8255", "#ff9b77" ]
    , [ "#a6641a", "#d07d20", "#ef973c", "#ffb256", "#ffc178" ]
    , [ "#9d8900", "#c4ab00", "#e8cb2d", "#ffe247", "#ffe86c" ]
    , [ "#7aa100", "#99c900", "#b6e521", "#d1ff43", "#daff69" ]
    , [ "#469922", "#57bf2a", "#3dd425", "#59f07c", "#7af396" ]
    , [ "#009356", "#00b86b", "#00d485", "#1ff1a0", "#4cf4b3" ]
    , [ "#00927e", "#00b79d", "#00d3b8", "#44f0d3", "#69f3dc" ]
    , [ "#228199", "#2aa1bf", "#3daee9", "#6dd3ff", "#8adcff" ]
    , [ "#7d499a", "#9c5bc0", "#b875dc", "#d792e7", "#dfa8ec" ]
    , [ "#5e44a0", "#7655c8", "#926ee4", "#af88ff", "#bfa0ff" ]
    , [ "#101114", "#1a1b1e", "#232629", "#2e3134", "#393c3f" ]
    , [ "#4f5356", "#5c5f62", "#686b6f", "#818488", "#9b9ea2" ]
    , [ "#a8abb0", "#b6b9bd", "#d1d5d9", "#eef1f5", "#fcffff" ]
    , [ "#440000", "#5d1800", "#6a250e", "#783019", "#873c23" ]
    , [ "#95482f", "#b26145", "#cb775a", "#ed9576", "#ffb090" ]
    , [ "#00223e", "#003756", "#004e6e", "#036688", "#327fa2" ]
    , [ "#5199bd", "#6eb4d9", "#8acff6", "#abe9fb" ]
    ]



-- UPDATE



update : Msg -> Model -> Model
update msg model =
    case msg of
        HoverColor str ->
            { model | hoveringColor = Just str, clicked = False }

        LeaveElement ->
            { model | hoveringColor = Nothing, clicked = False }

        CopyColor ->
            {model | clicked = True}



-- VIEW


icon : String -> String -> Html msg
icon name size =
    i
        [ class "icon"
        , class ("icon_" ++ name)
        , style "width" size
        , style "height" "size"
        , style "color" "white"
        , style "z-index" "1"
        ]
        []


stylesheet : String -> Html msg
stylesheet url =
    let
        tag =
            "link"

        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" url
            ]

        children =
            []
    in
    node tag attrs children


isColor : Model -> String -> Bool
isColor model color =
    case model.hoveringColor of
        Just it ->
            it == color

        Nothing ->
            False


colorBlock : Model -> String -> Html Msg
colorBlock model color =
    div
        [ style "background-color" color
        , style "width" "40px"
        , style "height" "40px"
        , style "display" "grid"
        , style "place-items" "center"
        , attribute "data-copy" color
        , onMouseEnter (HoverColor color)
        , onClick (CopyColor)
        ]
        (if isColor model color then
            [ div
                [ style "background-color" "rgba(0,0,0,0.5)"
                , style "width" "40px"
                , style "height" "40px"
                , style "position" "absolute"
                , style "z-index" "0"
                ]
                []
            , icon
                (if model.clicked then
                    "dialog-ok-apply"

                 else
                    "edit-copy"
                )
                "16px"
            ]

         else
            []
        )


colorRow : Model -> List String -> Html Msg
colorRow model colors =
    div
        [ style "flex-direction" "row"
        , style "display" "flex"
        , style "align-items" "center"
        ]
        (List.map (\it -> colorBlock model it) colors)


view : Model -> Html Msg
view model =
    div
        [ style "flex-direction" "column"
        , style "display" "flex"
        , style "align-items" "center"
        , style "width" "200px"
        , onMouseLeave LeaveElement
        ]
        (stylesheet "https://cdn.kde.org/breeze-icons/icons.css" :: List.map (\it -> colorRow model it) farben)
