module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes
import Html.Events exposing (..)
import List
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { dieFaceA : Int
    , dieFaceB : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { dieFaceA = 1
      , dieFaceB = 2
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Roll
    | NewFace ( Int, Int )


face : Random.Generator ( Int, Int )
face =
    Random.pair (Random.weighted ( 20, 1 ) [ ( 20, 2 ), ( 20, 3 ), ( 20, 4 ), ( 10, 5 ), ( 10, 6 ) ]) (Random.weighted ( 10, 1 ) [ ( 10, 2 ), ( 20, 3 ), ( 20, 4 ), ( 20, 5 ), ( 20, 6 ) ])


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace face
            )

        NewFace ( newFaceA, newFaceB ) ->
            ( { model | dieFaceA = newFaceA, dieFaceB = newFaceB }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ h1 []
                [ div [ Html.Attributes.style "display" "inline-block", Html.Attributes.style "width" "120px" ] [ Html.text (String.fromInt model.dieFaceA) ]
                , div [ Html.Attributes.style "display" "inline-block", Html.Attributes.style "width" "120px" ] [ Html.text (String.fromInt model.dieFaceB) ]
                ]
            ]
        , svg
            [ width "120", height "120", viewBox "0 0 120 120", fill "white", stroke "black", strokeWidth "3", Html.Attributes.style "padding-left" "20px" ]
            (List.append
                [ rect [ x "1", y "1", width "100", height "100", rx "15", ry "15" ] [] ]
                (svgCirclesForDieFace model.dieFaceA)
            )
        , svg
            [ width "120", height "120", viewBox "0 0 120 120", fill "white", stroke "black", strokeWidth "3", Html.Attributes.style "padding-left" "20px" ]
            (List.append
                [ rect [ x "1", y "1", width "100", height "100", rx "15", ry "15" ] [] ]
                (svgCirclesForDieFace model.dieFaceB)
            )
        , button [ onClick Roll ] [ Html.text "Roll" ]
        ]


svgCirclesForDieFace : Int -> List (Svg Msg)
svgCirclesForDieFace dieFace =
    case dieFace of
        1 ->
            [ circle [ cx "50", cy "50", r "10", fill "red", stroke "red" ] [] ]

        2 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            ]

        3 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "50", cy "50", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            ]

        4 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "75", cy "25", r "10", fill "black" ] []
            , circle [ cx "25", cy "75", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            ]

        5 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "75", cy "25", r "10", fill "black" ] []
            , circle [ cx "25", cy "75", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            , circle [ cx "50", cy "50", r "10", fill "black" ] []
            ]

        6 ->
            [ circle [ cx "25", cy "20", r "10", fill "black" ] []
            , circle [ cx "25", cy "50", r "10", fill "black" ] []
            , circle [ cx "25", cy "80", r "10", fill "black" ] []
            , circle [ cx "75", cy "20", r "10", fill "black" ] []
            , circle [ cx "75", cy "50", r "10", fill "black" ] []
            , circle [ cx "75", cy "80", r "10", fill "black" ] []
            ]

        _ ->
            []
