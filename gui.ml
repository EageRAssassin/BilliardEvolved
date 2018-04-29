open Types

(* canvas width and height *)
let canvas_width = 1041.
let canvas_height = 581.

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

let get_ball_img suit billiard = let img = "billiards.png" in
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

(*
(*if we have time we can implement multiple cues skins
  (i.e. 1 cue for each player)*)
let get_cue_img skin cue = failwith ""
(* let img = "cues.png" in (
  ) *)

let render_pool_cue c1 c2 = failwith

let get = failwith "" *)

(* [sprites_in_room sprites_list room_id] returns a list of all sprites in
   that room given the room_id. *)

(***************************** DRAWING *****************************)

(* [draw_image_on_context context img_src x y] draws the given [img_src]
   string at the x,y [coord] on the canvas' [context]. *)
let draw_image_on_context context img_src coord =
  let img = Html.createImg document in
  img##src <- img_src;
  context##drawImage ((img), (fst coord), (snd coord))

(* [fill_rect context (x,y) (w,h)] fills the given [x,y] with width [w]
   and height [h] with [color]. *)
let fill_rect context color (x,y) (w, h) =
  context##fillStyle <- (js color);
  context##fillRect (x, y, w, h)

(* [draw_billiard context billiard_on_board] draws all billiards on board*)


let draw_table (context: Html.canvasRenderingContext2D Js.t)
= draw_image_on_context context
  (js "pool_table_sm.png")
        (0.,0.)

(* [draw_room context room objects_list] draws the background
   and layout of the room. *)
let draw_room (context: Html.canvasRenderingContext2D Js.t) room =
  context##fillStyle <- js "black";
  context##fillRect (0., 0., canvas_width, canvas_height);
  draw_table context

(***************************** ANIMATING *****************************)

(* [clear canvas] clears the canvas of all drawing. *)
let clear (context: Html.canvasRenderingContext2D Js.t) =
  context##clearRect (0., 0., canvas_width, canvas_height)


let draw_state (context: Html.canvasRenderingContext2D Js.t) state =
  clear context;
  draw_table context
