open Types
open Billiards
open Player

(*acknolwedgement: uses oxcigen's js_of_ocaml module under the public domain
 https://github.com/ocsigen/js_of_ocaml *)

(* canvas width and height *)
let canvas_width = 1401.
let canvas_height = 800.

(* js_of_ocaml helper declarations *)
(* see http://ocsigen.org/js_of_ocaml/3.1.0/api/Dom_html for specifications
   and ttps://github.com/ocsigen/js_of_ocaml for an example of their usage
   in /examples/minesweeper.ml *)

module Html = Dom_html
let js = Js.string
let document = Html.document

let get_ball_img suit billiard:billiard = let img = "billiards.png" in
    match suit with
    | 0 -> {billiard with dim = {img; size = (30.,30.); offset = (0.,0.);}}
    | 1 -> {billiard with dim = {img; size = (30.,30.); offset = (50.,0.);}}
    | 2 -> {billiard with dim = {img; size = (30.,30.); offset = (100.,0.);}}
    | 3 -> {billiard with dim = {img; size = (30.,30.); offset = (150.,0.);}}
    | 4 -> {billiard with dim = {img; size = (30.,30.); offset = (200.,0.);}}
    | 5 -> {billiard with dim = {img; size = (30.,30.); offset = (250.,0.);}}
    | 6 -> {billiard with dim = {img; size = (30.,30.); offset = (300.,0.);}}
    | 7 -> {billiard with dim = {img; size = (30.,30.); offset = (350.,0.);}}
    | 8 -> {billiard with dim = {img; size = (30.,30.); offset = (400.,0.);}}
    | 9 -> {billiard with dim = {img; size = (30.,30.); offset = (450.,0.);}}
    | 10 -> {billiard with dim = {img; size = (30.,30.); offset = (500.,0.);}}
    | 11 -> {billiard with dim = {img; size = (30.,30.); offset = (550.,0.);}}
    | 12 -> {billiard with dim = {img; size = (30.,30.); offset = (600.,0.);}}
    | 13 -> {billiard with dim = {img; size = (30.,30.); offset = (650.,0.);}}
    | 14 -> {billiard with dim = {img; size = (30.,30.); offset = (700.,0.);}}
    | 15 -> {billiard with dim = {img; size = (30.,30.); offset = (750.,0.);}}
    | _ -> failwith ""

(* let get_cue_img name pool_cue = let img = "pool_cue.png" in
  match name with
  | _ -> {pool_cue with cue_dim = {img; size = (30.,30.); offset = (0.,0.);}} *)

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

let draw_help context (b: billiard) (x, y)=
  let img = Html.createImg document in
  let (sx, sy) = b.dim.offset in
  let (sw, sh) = b.dim.size in
  img##src <- js b.dim.img;
  context##drawImage_full (img, sx, sy, sw, sh, x, y, sw, sh)

(**)

(* [draw_billiard context b] draws the billiard on the given context. *)
let draw_billiard (context: Html.canvasRenderingContext2D Js.t) (b: billiard)=
  let suit = b.suit in
  let choose_b = get_ball_img suit b in
  draw_help context choose_b b.position

let draw_billiards (context: Html.canvasRenderingContext2D Js.t) b_list =
  List.map (fun b -> draw_billiard context b) b_list |> ignore

let draw_table (context: Html.canvasRenderingContext2D Js.t)
  = draw_image_on_context context (js "pool_table_sm.png") (0.,0.)

let draw_cue (context: Html.canvasRenderingContext2D Js.t) c
  = draw_image_on_context context (js "pool_cue.png") c

let stat_helper (context: Html.canvasRenderingContext2D Js.t) (b: billiard) =
  let s = b.suit in
  (* let s' = float_of_int b.suit in *)
  if (s = 0 || s = 8 || s < 0 || s > 15) then draw_help context b (2000.,2000.)
  else
    let x = (185 + ((s-1) mod 4) * 35 + ((s-1) / 8) * 350 ) in
    let y = ((((s-1) mod 8) / 4) * 35 + 600) in
    let choose_b = get_ball_img s b in
    draw_help context choose_b (float_of_int x, float_of_int y)

let draw_stat (context: Html.canvasRenderingContext2D Js.t) b_list =
  List.map (fun b -> stat_helper context b) b_list |> ignore

let draw_control c =
  draw_image_on_context c (js "controls.png") (1150., 0.)

(* placeholders *)
let draw_p1 c =
  draw_image_on_context c (js "human.png") (100., 595.)

let draw_p2 c =
  draw_image_on_context c (js "computer.png") (450., 595.)

let draw_turn c p =
  if p then
    draw_image_on_context c (js "turn.png") (57., 615.)
  else
    draw_image_on_context c (js "turn.png") (407., 615.)

let draw_score_p1 context n =
  let score = js ("P1: " ^ string_of_int n) in
  context##font <- js "25px Triforce";
  context##fillText (score, 360., 645.)

let draw_score_p2 context n =
  let score = js ("P2: " ^ string_of_int n) in
  context##font <- js "25px Triforce";
  context##fillText (score, 710., 645.)

(*
  (*single ball test *)
let draw_b (context: Html.canvasRenderingContext2D Js.t)
  = draw_image_on_context context
    (js "8.png")
    (500.,250.);
    draw_billiard context cue_ball *)
(*
(* consider deletion *)
let b_on_table b_lst table_id =
  List.filter (fun (b: billiard) -> b.location.room = room_id) b_lst *)

(***************************** ANIMATING *****************************)

(* [clear canvas] clears the canvas of all drawing. *)
let clear (context: Html.canvasRenderingContext2D Js.t) =
  context##clearRect (0., 0., canvas_width, canvas_height)


let draw_state (context: Html.canvasRenderingContext2D Js.t) state =
  clear context;
  draw_control context;
  draw_p1 context;
  draw_p2 context;
  draw_score_p1 context player1.score;
  draw_score_p2 context player2.score;
  draw_turn context (state.is_playing = player1);
  draw_table context;
  draw_cue context state.cue_pos;
  (* draw_billiards context [cue_ball; one_ball; two_ball; three_ball; four_ball; five_ball;
                          six_ball; seven_ball; eight_ball; nine_ball; ten_ball; eleven_ball; twelve_ball;
                          thirteen_ball; fourteen_ball; fifteen_ball] *)
  draw_billiards context state.on_board;
  draw_stat context state.on_board
