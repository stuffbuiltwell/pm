module Main exposing (main)

import Browser
import Html exposing (..)


main : Program () Int ()
main =
    Browser.sandbox { init = 0, update = \_ _ -> 0, view = \_ -> div [] [ p [] [text "hello"] ] }
