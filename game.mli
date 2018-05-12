open Types

(* [game_loop context st has_won] controls the game loop and draws the updates
   to the canvas *)
val game_loop: Dom_html.canvasRenderingContext2D Js.t -> bool -> unit
(* controls keyup and keydown for wasdj*)

(* [keydown event] registers when a key has been pressed. *)
val keydown : Dom_html.keyboardEvent Js.t -> bool Js.t

(* [keyup event] registers when a key has been lifted. *)
val keyup : Dom_html.keyboardEvent Js.t -> bool Js.t

(* [mousemove event] returns the coords of the cursor on the screen
   of the game (the canvas)*)
val mousemove : Dom_html.mouseEvent Js.t -> bool Js.t

(* [mousemove event] registers a left click clicked *)
val mousedown : Dom_html.mouseEvent Js.t -> bool Js.t

(* [mousemove event] registers a left click lifted *)
val mouseup : Dom_html.mouseEvent Js.t -> bool Js.t
