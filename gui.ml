(* open State
open Player
open Main
   open Billiard  *)
open Types

let surface_width = 600.
let surface_height = 1200. (* within range of international
                              convention of playing surface *)

let draw_init = failwith ""
  (*get the table.png and draw this at the start.
    then assign all billiards to their init position within the triangular formation
    do this once; only have the billairds move; the table stays constant *)

let get_ball_img suit bill = let img = "billiards.png" in (
    match suit with
    | 0 -> {billiard with dim = {img; size = (25.,25.); offset = (0.,75.);}}
    | 1 -> {billiard with dim = {img; size = (25.,25.); offset = (50.,75.);}}
    | 2 -> {billiard with dim = {img; size = (25.,25.); offset = (100.,75.);}}
    | 3 -> {billiard with dim = {img; size = (25.,25.); offset = (150.,75.);}}
    | 4 -> {billiard with dim = {img; size = (25.,25.); offset = (200.,75.);}}
    | 5 -> {billiard with dim = {img; size = (25.,25.); offset = (250.,75.);}}
    | 6 -> {billiard with dim = {img; size = (25.,25.); offset = (300.,75.);}}
    | 7 -> {billiard with dim = {img; size = (25.,25.); offset = (350.,75.);}}
    | 8 -> {billiard with dim = {img; size = (25.,25.); offset = (400.,75.);}}
    | 9 -> {billiard with dim = {img; size = (25.,25.); offset = (450.,75.);}}
    | 10 -> {billiard with dim = {img; size = (25.,25.); offset = (500.,75.);}}
    | 11 -> {billiard with dim = {img; size = (25.,25.); offset = (550.,75.);}}
    | 12 -> {billiard with dim = {img; size = (25.,25.); offset = (600.,75.);}}
    | 13 -> {billiard with dim = {img; size = (25.,25.); offset = (650.,75.);}}
    | 14 -> {billiard with dim = {img; size = (25.,25.); offset = (700.,75.);}}
    | 15 -> {billiard with dim = {img; size = (25.,25.); offset = (750.,75.);}}
    | _ -> failwith ""
  )

(*if we have time we can implement multiple cues skins
  (i.e. 1 cue for each player)*)
let get_cue_img skin cue = failwith ""
(* let img = "cues.png" in (
  ) *)

let render_pool_cue c1 c2 =
  (*since the pool cue placement is determined by mouse clicks, it would
    make sense to use a function to draw the cue on the spot according to
    user input mouse input
    c1 and c2 are user mouse coordinates *)
  Graphics.lineto c1 c2 (* for now, the cue is just a line *)


let get = failwith ""

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
