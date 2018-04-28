(* open State
open Player
open Main
   open Billiard  *)
open Graphics

module Html = Dom_html
let js = Js.string
let document = Html.document

let surface_width = 600.
let surface_height = 1200. (* within range of international
                              convention of playing surface *)

let draw_init =
  (*get the table.png and draw this at the start.
    then assign all billiards to their init position within the triangular formation
    do this once; only have the billairds move; the table stays constant *)

let get_ball_img num bill = (match num with
  | 0 -> (*cue ball*)
  | 1 -> (*1 ball, solid yellow*)
    (*...*)
  | 15 -> (*15 ball, striped brown*)
  | _ -> (*non-existent ball, throw some kind of error *)
  )

let render_pool_cue c1 c2 =
  (*since the pool cue placement is determined by mouse clicks, it would
    make sense to use a function to draw the cue on the spot according to
    user input mouse input
    c1 and c2 are user mouse coordinates *)
  Graphics.lineto c1 c2 (* for now, the cue is just a line *)

let get_coord obj = obj.position

let get

(* mouse and keyboard controls as seen in graphics module of OCaml *)

(*type status = {
  mouse_x : int;	(*
  X coordinate of the mouse

 *)
  mouse_y : int;	(*
  Y coordinate of the mouse

 *)
  button : bool;	(*
  true if a mouse button is pressed

 *)
  keypressed : bool;	(*
  true if a key has been pressed

 *)
  key : char;	(*
  the character for the key pressed

 *)
  }
  To report events.

  type event =
  |	Button_down	(*
  A mouse button is pressed

 *)
  |	Button_up	(*
  A mouse button is released

 *)
  |	Key_pressed	(*
  A key is pressed

 *)
  |	Mouse_motion	(*
  The mouse is moved

 *)
  |	Poll	(*
  Don't wait; return immediately

 *)
  To specify events to wait for.

*)
