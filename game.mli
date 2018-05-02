open Types

(* [game_loop context st has_won] controls the game loop and draws the updates
   to the canvas *)
val game_loop: Dom_html.canvasRenderingContext2D Js.t -> bool -> unit
(* controls keyup and keydown for wasdj*)
