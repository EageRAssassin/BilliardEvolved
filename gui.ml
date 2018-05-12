open Types
open Billiards
open Player

(*acknolwedgement: uses oxcigen's js_of_ocaml module under the public domain
 https://github.com/ocsigen/js_of_ocaml *)

(* canvas width and height *)
let canvas_width = 1501.
let canvas_height = 1000.

let rad d = d *. 3.1415926 /. 180.
let make_d r = r *. 180. /. 3.1415926

(* js_of_ocaml helper declarations *)
(* see http://ocsigen.org/js_of_ocaml/3.1.0/api/Dom_html for specifications
   and ttps://github.com/ocsigen/js_of_ocaml for an example of their usage
   in /examples/minesweeper.ml *)

module Html = Dom_html
let js = Js.string
let document = Html.document

let get_ball_img suit billiard velocity counter : billiard =
  let img = "billiards.png" in
  if ( (fst velocity) *. (snd velocity) < 10. ) || counter mod 30 < 15 then
    match billiard.suit with
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
  else
    match billiard.suit with
    | 0 -> {billiard with dim = {img; size = (30.,30.); offset = (0.,50.);}}
    | 1 -> {billiard with dim = {img; size = (30.,30.); offset = (50.,50.);}}
    | 2 -> {billiard with dim = {img; size = (30.,30.); offset = (100.,50.);}}
    | 3 -> {billiard with dim = {img; size = (30.,30.); offset = (150.,50.);}}
    | 4 -> {billiard with dim = {img; size = (30.,30.); offset = (200.,50.);}}
    | 5 -> {billiard with dim = {img; size = (30.,30.); offset = (250.,50.);}}
    | 6 -> {billiard with dim = {img; size = (30.,30.); offset = (300.,50.);}}
    | 7 -> {billiard with dim = {img; size = (30.,30.); offset = (350.,50.);}}
    | 8 -> {billiard with dim = {img; size = (30.,30.); offset = (400.,50.);}}
    | 9 -> {billiard with dim = {img; size = (30.,30.); offset = (450.,50.);}}
    | 10 -> {billiard with dim = {img; size = (30.,30.); offset = (500.,50.);}}
    | 11 -> {billiard with dim = {img; size = (30.,30.); offset = (550.,50.);}}
    | 12 -> {billiard with dim = {img; size = (30.,30.); offset = (600.,50.);}}
    | 13 -> {billiard with dim = {img; size = (30.,30.); offset = (650.,50.);}}
    | 14 -> {billiard with dim = {img; size = (30.,30.); offset = (700.,50.);}}
    | 15 -> {billiard with dim = {img; size = (30.,30.); offset = (750.,50.);}}
    | _ -> failwith ""

(* let roll_ball_img suit billiard velocity counter =
  let guard = (counter mod 5 = 0 && velocity <> (0.,0.)) in
  let img = "billiards.png" in
  let b = get_ball_img suit billiard in
  if guard then
    if snd b.dim.offset = 0. then
      b.dim <- {img = img; size = (30., 30.);
                offset = (fst b.dim.offset, snd b.dim.offset +. 50. )}
    else
      b.dim <- {img = img; size = (30., 30.);
                offset = (fst b.dim.offset, snd b.dim.offset -. 50. )}
  else
    b.dim <- b.dim *)


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

(*https://developer.mozilla.org/en-US/docs/Web/API
  /CanvasRenderingContext2D/drawImage*)

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

let draw_angle context bearing img_src coord =
  let img = Html.createImg document in
  img##src <- img_src;
  context##rotate((bearing *. 3.14) /. 180.);
  context##drawImage ((img), (fst coord), (snd coord))
(**)

(* [draw_billiard context b] draws the billiard on the given context. *)
let draw_billiard (context: Html.canvasRenderingContext2D Js.t) (b: billiard) counter=
  let suit = b.suit in
  let choose_b = get_ball_img suit b b.velocity counter in
  let pos = (fst b.position -. 15., snd b.position -. 15.) in
  draw_help context choose_b pos

let draw_billiards (context: Html.canvasRenderingContext2D Js.t) b_list counter =
  List.map (fun b -> draw_billiard context b counter) b_list |> ignore

let draw_table (context: Html.canvasRenderingContext2D Js.t)
  = draw_image_on_context context (js "pool_table_sm.png") (100.,100.)
(*
let draw_cue (context: Html.canvasRenderingContext2D Js.t) b coord =
  let pos = (fst coord -. 15., snd coord -. 15.) in
  draw_angle context b (js "pool_cue.png") coord *)

let stat_helper (context: Html.canvasRenderingContext2D Js.t) (b: billiard) =
  let s = b.suit in
  (* let s' = float_of_int b.suit in *)
  if (s = 0 || s = 8 || s < 0 || s > 15) then draw_help context b (20000.,20000.)
  else
    let x = (185 + ((s-1) mod 4) * 35 + ((s-1) / 8) * 400 ) in
    let y = ((((s-1) mod 8) / 4) * 35 + 10) in
    let choose_b = get_ball_img s b (0.,0.) 0 in
    draw_help context choose_b (float_of_int x, float_of_int y)

let draw_stat (context: Html.canvasRenderingContext2D Js.t) b_list =
  List.map (fun b -> stat_helper context b) b_list |> ignore

let draw_control c =
  draw_image_on_context c (js "controls.png") (1250., 0.)

(* placeholders *)
let draw_p1 c =
  draw_image_on_context c (js "human.png") (100., 5.)

let draw_p2 c =
  draw_image_on_context c (js "computer.png") (500., 5.)

let draw_turn c p =
  if p then
    draw_image_on_context c (js "turn.png") (57., 25.)
  else
    draw_image_on_context c (js "turn.png") (457., 25.)

let draw_score_p1 context n =
  let score = js ("P1: " ^ string_of_int n) in
  context##font <- js "25px Triforce";
  context##fillText (score, 360., 55.)

let draw_score_p2 context n =
  let score = js ("P2: " ^ string_of_int n) in
  context##font <- js "25px Triforce";
  context##fillText (score, 760., 55.)

let draw_debug context str y =
  let text = js (str) in
  context##font <- js "15px Triforce";
  context##fillText (text, 1200., y)

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


(* let offset a1 a2 d g1 g2 =
  let a = sqrt (a1 ** 2. +. a2 ** 2.) in
  let g = sqrt (g1 ** 2. +. g2 ** 2.) in
  let t = rad (d /. 2.) in
  let ratio = g /. a in
  let b = 2. *. a *. Pervasives.sin t in
  let x = 2. *. a *. ((Pervasives.sin t) ** 2.) in
  let y = 2. *. a *. ((Pervasives.cos t) ** 2.) in
  (x +. x *. ratio, y +. y *. ratio) *)

(* let get_quadrant st =
  let bearing = float_of_int ((int_of_float st.cue_bearing) mod 360) in
  if bearing <= 90. then 1
  else if st.cue_bearing <= 180. then 2
  else if st.cue_bearing <= 270. then 3
  else 4 *)

(* let opposite a1 a2 deg =
  let a = sqrt (a1 ** 2. +. a2 ** 2.) in
  let t = (deg /. 2.) in 2. *. a *. (Pervasives.sin t) *)

(* let get_offset a1 a2 deg =
  let opp = opposite a1 a2 deg in
  let tot_d = make_d (Pervasives.atan (a2 /. a1)) in
  let help_d = 90. -. (180. -. tot_d -. ((180. -. deg) /. 2. )) in
  (opp *. Pervasives.sin (rad help_d), opp *. Pervasives.cos (rad help_d))

let get_total_offset a1 a2 g1 g2 deg =
  let x = fst (get_offset a1 a2 deg) +. fst (get_offset g1 g2 deg) in
  let y = (-1. *. snd (get_offset a1 a2 deg)) +. snd (get_offset g1 g2 deg) in
  (x,y) *)

(* let get_quad_2_offset bx by bearing gap = (* bearing in rads *)
  let theta1 = Pervasives.atan (by /. bx) in
  let theta2 = bearing -. theta1 in
  let theta25 = (3.1415926 -. theta2) /. 2. in
  let theta3 = (3.1415926 /. 2.) -. theta1 -. theta25 in
  (* let b = sqrt ((bx ** 2.) +. (by ** 2.)) in *)
  let bt = opposite bx by bearing in
  let y1 = bt *. Pervasives.cos (theta3) in
  let x1 = bt *. Pervasives.sin (theta3) in
  let xg = gap in
  ((bx +. xg -. x1), (by -. y1))

let draw_rotated2 context degrees img bx by gap =
  let deg = rad degrees in
  context##save();
  (* context##translate(bx, by); *)
  context##rotate(degrees *. 3.1416926 /. 180.);
  draw_image_on_context context (js img) (get_quad_2_offset bx by deg gap);
  context##restore();
  draw_debug context ("deg (rad): " ^
                      (string_of_float deg)) 450. ;
  draw_debug context ("offset: (" ^
                      (string_of_float (fst (get_quad_2_offset bx by deg gap))) ^ ", " ^
                      (string_of_float (snd (get_quad_2_offset bx by deg gap))) ^ ")") 400. *)
(* let draw_rotated context degrees img a1 a2 g1 g2 =
  (* clear context; *)
  (* let crd = ((canvas_width /. 2.) -. w , (canvas_height /. 2.) -. h) in *)
  context##save();
  context##rotate(degrees *. 3.1416926 /. 180.);
  (* context##translate (fst coord, snd coord); *)
  let gap = 180. -. (float_of_int (abs (int_of_float (degrees -. 180.)))) in
  let offset1 = (gap /. 1.0) +. fst (get_total_offset a1 a2 g1 g2 degrees) in
  let offset2 = (-1. *. 6.) +. snd (get_total_offset a1 a2 g1 g2 degrees) in
  draw_image_on_context context (js img)
    (a1 +. (gap /. 1.0) +. fst (get_total_offset a1 a2 g1 g2 degrees) ,
     a2 -. 6. +. snd (get_total_offset a1 a2 g1 g2 degrees));
  (* draw_image_on_context context (js img) (a1 , a2 -. 0.); *)
  (* context##translate(canvas_width /. 2., canvas_height /. 2.); *)
  (* context##rotate(degrees *. 3.14 /. 180.); *)
  (* context##translate ((fst coord) -. (fst crd), (snd coord) -. (snd crd)); *)
  (* context##translate(canvas_width /. -2., canvas_height /. -2.); *)
  context##restore();
  draw_debug context ("offset: (" ^
                      (string_of_float (offset1)) ^ ", " ^
                      (string_of_float (offset2)) ^ ")") 400. *)

let draw_rotated2 context degrees img bx by gap =
  (* let deg = rad degrees in *)
  context##save();
  context##translate(bx, by);
  context##rotate(degrees *. 3.1416926 /. 180.);
  draw_image_on_context context (js img) (gap, -1. *. 6.);
  draw_image_on_context context
    (js "fokn_laser_sight.png") ( -600. , 0.);
  context##restore();
  draw_debug context ("deg: " ^
                      (string_of_float degrees)) 400.
  (* draw_debug context ("offset: (" ^
                      (string_of_float (fst (get_quad_2_offset bx by deg gap))) ^ ", " ^
                      (string_of_float (snd (get_quad_2_offset bx by deg gap))) ^ ")") 400. *)

(* trig offset helpers *)

let draw_state (context: Html.canvasRenderingContext2D Js.t) state =
  clear context;
  draw_control context;
  draw_p1 context;
  draw_p2 context;
  draw_score_p1 context player1.score;
  draw_score_p2 context player2.score;
  draw_turn context (state.is_playing = player1);
  draw_table context;
  draw_billiards context state.on_board state.counter;
  draw_debug context ("cue_ball.position: (" ^
                      (string_of_float (fst cue_ball.position)) ^ ", " ^
                      (string_of_float (snd cue_ball.position)) ^ ")") 300.;
  draw_debug context ("cue_pos: (" ^
                      (string_of_float (fst state.cue_pos)) ^ ", " ^
                      (string_of_float (snd state.cue_pos)) ^ ")") 350.;
  draw_debug context ("state number: " ^ (string_of_int state.counter)) 800.;
  (* let g1 = fst (state.cue_pos) -. fst cue_ball.position in
     let g2 = snd (state.cue_pos) -. snd cue_ball.position in *)
  if state.ball_moving = false then
 (* let a1 = state.gap +. fst cue_ball.position in let a2 = snd cue_ball.position in
    let g1 = fst state.cue_pos -. fst cue_ball.position in
    let g2 = snd state.cue_pos -. snd cue_ball.position in *)
    let a1 = fst cue_ball.position in let a2 = snd cue_ball.position in
    let gap = state.gap in let bearing = state.cue_bearing in
    (* draw_rotated context state.cue_bearing "pool_cue.png" a1 a2 g1 g2 *)
    draw_rotated2 context bearing "pool_cue.png" a1 a2 gap
  else
    draw_image_on_context context (js "pool_cue_vert.png") (1150., 150.) ;

     (* let a1 = ((fst cue_ball.position) +. 45.) in let a2 = snd cue_ball.position in
     let g1 = fst state.cue_pos -. fst cue_ball.position in
     let g2 = snd state.cue_pos -. snd cue_ball.position in
draw_rotated context state.cue_bearing "pool_cue.png" a1 a2 g1 g2; *)
  (* draw_cue context state.cue_bearing state.cue_pos; *)
  (* draw_billiards context [cue_ball; one_ball; two_ball; three_ball;
     four_ball; five_ball; six_ball; seven_ball; eight_ball; nine_ball;
     ten_ball; eleven_ball; twelve_ball; thirteen_ball; fourteen_ball;
     fifteen_ball] *)
  draw_stat context state.on_board
