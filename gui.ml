open Types
open Billiards

(* canvas width and height *)
let canvas_width = 1041.
let canvas_height = 581.

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

let get_ball_img suit billiard = let img = "billiards.png" in
    match suit with
    | 0 -> {billiard with dim = {img; size = (25.,25.); offset = (0.,0.);}}
    | 1 -> {billiard with dim = {img; size = (25.,25.); offset = (50.,0.);}}
    | 2 -> {billiard with dim = {img; size = (25.,25.); offset = (100.,0.);}}
    | 3 -> {billiard with dim = {img; size = (25.,25.); offset = (150.,0.);}}
    | 4 -> {billiard with dim = {img; size = (25.,25.); offset = (200.,0.);}}
    | 5 -> {billiard with dim = {img; size = (25.,25.); offset = (250.,0.);}}
    | 6 -> {billiard with dim = {img; size = (25.,25.); offset = (300.,0.);}}
    | 7 -> {billiard with dim = {img; size = (25.,25.); offset = (350.,0.);}}
    | 8 -> {billiard with dim = {img; size = (25.,25.); offset = (400.,0.);}}
    | 9 -> {billiard with dim = {img; size = (25.,25.); offset = (450.,0.);}}
    | 10 -> {billiard with dim = {img; size = (25.,25.); offset = (500.,0.);}}
    | 11 -> {billiard with dim = {img; size = (25.,25.); offset = (550.,0.);}}
    | 12 -> {billiard with dim = {img; size = (25.,25.); offset = (600.,0.);}}
    | 13 -> {billiard with dim = {img; size = (25.,25.); offset = (650.,0.);}}
    | 14 -> {billiard with dim = {img; size = (25.,25.); offset = (700.,0.);}}
    | 15 -> {billiard with dim = {img; size = (25.,25.); offset = (750.,0.);}}
    | _ -> failwith ""

(*
(*if we have time we can implement multiple cues skins
  (i.e. 1 cue for each player)*)
let get_cue_img skin cue = failwith ""
(* let img = "cues.png" in (
  ) *)

let render_pool_cue c1 c2 = failwith

let get = failwith "" *)

(***************************** DRAWING *****************************)

(* [draw_image_on_context context img_src x y] draws the given [img_src]
   string at the x,y [coord] on the canvas' [context]. *)
let draw_image_on_context context img_src coord =
  let img = Html.createImg document in
  img##src <- img_src;
  context##drawImage ((img), (fst coord), (snd coord))

let draw_help context (b: billiard) =
  let img = Html.createImg document in
  let (sx, sy) = b.dim.offset in
  let (sw, sh) = b.dim.size in
  let (x, y) = b.position in
  img##src <- js b.dim.img;
  context##drawImage_full (img, sx, sy, sw, sh, x, y, sw, sh)

(* [draw_billiard context b] draws the billiard on the given context. *)
let draw_billiard (context: Html.canvasRenderingContext2D Js.t) (b: billiard) =
  let suit = b.suit in
  let choose_b = get_ball_img suit b in
  draw_help context choose_b

let draw_billiards (context: Html.canvasRenderingContext2D Js.t) b_list =
  List.map (fun b -> draw_billiard context b) b_list |> ignore

let draw_table (context: Html.canvasRenderingContext2D Js.t)
= draw_image_on_context context
  (js "pool_table_sm.png")
  (0.,0.)

  (*single ball test *)
let draw_b (context: Html.canvasRenderingContext2D Js.t)
  = draw_image_on_context context
    (js "8.png")
    (500.,250.);
    draw_billiard context cue_ball

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
  draw_table context;
  draw_billiards context [cue_ball; one_ball; two_ball; three_ball; four_ball; five_ball;
                          six_ball; seven_ball; eight_ball; nine_ball; ten_ball; eleven_ball; twelve_ball;
                          thirteen_ball; fourteen_ball; fifteen_ball]
