open Types
open Billiards
open Player

(*acknolwedgement: uses oxcigen's js_of_ocaml module under the public domain
 https://github.com/ocsigen/js_of_ocaml *)

(* canvas width and height which is the size of the context window *)
let canvas_width = 1331.
let canvas_height = 741.

(* helper functions for translation between angular degrees and radians  *)
let rad d = d *. 3.1415926 /. 180.
let make_d r = r *. 180. /. 3.1415926

(* js_of_ocaml helper declarations *)
(* see http://ocsigen.org/js_of_ocaml/3.1.0/api/Dom_html for specifications
   and ttps://github.com/ocsigen/js_of_ocaml for an example of their usage
   in /examples/minesweeper.ml for the basic declarations *)

module Html = Dom_html
let js = Js.string
let document = Html.document

(* [get_ball_img] selects the ball's png representation based on its
   suit. rotation is simulated by alternating between different orientations
   of the billiard if it is moving every few frames *)
let get_ball_img suit billiard velocity counter egg : billiard =
  if egg = false then
  let img = "media/billiards.png" in
  (* ball is stationary or face up *)
  let spd = 50. in
  if ( sqrt (((fst velocity) ** 2.) +. ((snd velocity) ** 2.)) <= spd )
  || counter mod 20 < 5 then
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
  (* ball is moving vertically *)
  else if abs_float ( snd velocity) >= abs_float (fst velocity)
       && counter mod 20 > 4 && counter mod 20 < 10
       && ( (sqrt ((fst velocity) ** 2.) +. ((snd velocity) ** 2.)) > spd) then
    match billiard.suit with
    | 0 -> {billiard with dim = {img; size = (30.,30.); offset = (0.,100.);}}
    | 1 -> {billiard with dim = {img; size = (30.,30.); offset = (50.,100.);}}
    | 2 -> {billiard with dim = {img; size = (30.,30.); offset = (100.,100.);}}
    | 3 -> {billiard with dim = {img; size = (30.,30.); offset = (150.,100.);}}
    | 4 -> {billiard with dim = {img; size = (30.,30.); offset = (200.,100.);}}
    | 5 -> {billiard with dim = {img; size = (30.,30.); offset = (250.,100.);}}
    | 6 -> {billiard with dim = {img; size = (30.,30.); offset = (300.,100.);}}
    | 7 -> {billiard with dim = {img; size = (30.,30.); offset = (350.,100.);}}
    | 8 -> {billiard with dim = {img; size = (30.,30.); offset = (400.,100.);}}
    | 9 -> {billiard with dim = {img; size = (30.,30.); offset = (450.,100.);}}
    | 10 -> {billiard with dim = {img; size = (30.,30.); offset = (500.,100.);}}
    | 11 -> {billiard with dim = {img; size = (30.,30.); offset = (550.,100.);}}
    | 12 -> {billiard with dim = {img; size = (30.,30.); offset = (600.,100.);}}
    | 13 -> {billiard with dim = {img; size = (30.,30.); offset = (650.,100.);}}
    | 14 -> {billiard with dim = {img; size = (30.,30.); offset = (700.,100.);}}
    | 15 -> {billiard with dim = {img; size = (30.,30.); offset = (750.,100.);}}
    | _ -> failwith ""
  else if abs_float (snd velocity) >= abs_float (fst velocity)
       && counter mod 20 > 14 && counter mod 20 < 20
       && ( (sqrt ((fst velocity) ** 2.) +. ((snd velocity) ** 2.)) > spd) then
    match billiard.suit with
    | 0 -> {billiard with dim = {img; size = (30.,30.); offset = (0.,150.);}}
    | 1 -> {billiard with dim = {img; size = (30.,30.); offset = (50.,150.);}}
    | 2 -> {billiard with dim = {img; size = (30.,30.); offset = (100.,150.);}}
    | 3 -> {billiard with dim = {img; size = (30.,30.); offset = (150.,150.);}}
    | 4 -> {billiard with dim = {img; size = (30.,30.); offset = (200.,150.);}}
    | 5 -> {billiard with dim = {img; size = (30.,30.); offset = (250.,150.);}}
    | 6 -> {billiard with dim = {img; size = (30.,30.); offset = (300.,150.);}}
    | 7 -> {billiard with dim = {img; size = (30.,30.); offset = (350.,150.);}}
    | 8 -> {billiard with dim = {img; size = (30.,30.); offset = (400.,150.);}}
    | 9 -> {billiard with dim = {img; size = (30.,30.); offset = (450.,150.);}}
    | 10 -> {billiard with dim = {img; size = (30.,30.); offset = (500.,150.);}}
    | 11 -> {billiard with dim = {img; size = (30.,30.); offset = (550.,150.);}}
    | 12 -> {billiard with dim = {img; size = (30.,30.); offset = (600.,150.);}}
    | 13 -> {billiard with dim = {img; size = (30.,30.); offset = (650.,150.);}}
    | 14 -> {billiard with dim = {img; size = (30.,30.); offset = (700.,150.);}}
    | 15 -> {billiard with dim = {img; size = (30.,30.); offset = (750.,150.);}}
    | _ -> failwith ""
  else if abs_float (fst velocity) > abs_float (snd velocity)
       && counter mod 20 > 4 && counter mod 20 < 10
       && ( (sqrt ((fst velocity) ** 2.) +. ((snd velocity) ** 2.)) > spd) then
    match billiard.suit with
    | 0 -> {billiard with dim = {img; size = (30.,30.); offset = (0.,200.);}}
    | 1 -> {billiard with dim = {img; size = (30.,30.); offset = (50.,200.);}}
    | 2 -> {billiard with dim = {img; size = (30.,30.); offset = (100.,200.);}}
    | 3 -> {billiard with dim = {img; size = (30.,30.); offset = (150.,200.);}}
    | 4 -> {billiard with dim = {img; size = (30.,30.); offset = (200.,200.);}}
    | 5 -> {billiard with dim = {img; size = (30.,30.); offset = (250.,200.);}}
    | 6 -> {billiard with dim = {img; size = (30.,30.); offset = (300.,200.);}}
    | 7 -> {billiard with dim = {img; size = (30.,30.); offset = (350.,200.);}}
    | 8 -> {billiard with dim = {img; size = (30.,30.); offset = (400.,200.);}}
    | 9 -> {billiard with dim = {img; size = (30.,30.); offset = (450.,200.);}}
    | 10 -> {billiard with dim = {img; size = (30.,30.); offset = (500.,200.);}}
    | 11 -> {billiard with dim = {img; size = (30.,30.); offset = (550.,200.);}}
    | 12 -> {billiard with dim = {img; size = (30.,30.); offset = (600.,200.);}}
    | 13 -> {billiard with dim = {img; size = (30.,30.); offset = (650.,200.);}}
    | 14 -> {billiard with dim = {img; size = (30.,30.); offset = (700.,200.);}}
    | 15 -> {billiard with dim = {img; size = (30.,30.); offset = (750.,200.);}}
    | _ -> failwith ""
(*horizontal movement*)
  else if abs_float (fst velocity) > abs_float (snd velocity)
       && counter mod 20 > 14 && counter mod 20 < 20
       && ( (sqrt ((fst velocity) ** 2.) +. ((snd velocity) ** 2.)) > spd) then
    match billiard.suit with
    | 0 -> {billiard with dim = {img; size = (30.,30.); offset = (0.,250.);}}
    | 1 -> {billiard with dim = {img; size = (30.,30.); offset = (50.,250.);}}
    | 2 -> {billiard with dim = {img; size = (30.,30.); offset = (100.,250.);}}
    | 3 -> {billiard with dim = {img; size = (30.,30.); offset = (150.,250.);}}
    | 4 -> {billiard with dim = {img; size = (30.,30.); offset = (200.,250.);}}
    | 5 -> {billiard with dim = {img; size = (30.,30.); offset = (250.,250.);}}
    | 6 -> {billiard with dim = {img; size = (30.,30.); offset = (300.,250.);}}
    | 7 -> {billiard with dim = {img; size = (30.,30.); offset = (350.,250.);}}
    | 8 -> {billiard with dim = {img; size = (30.,30.); offset = (400.,250.);}}
    | 9 -> {billiard with dim = {img; size = (30.,30.); offset = (450.,250.);}}
    | 10 -> {billiard with dim = {img; size = (30.,30.); offset = (500.,250.);}}
    | 11 -> {billiard with dim = {img; size = (30.,30.); offset = (550.,250.);}}
    | 12 -> {billiard with dim = {img; size = (30.,30.); offset = (600.,250.);}}
    | 13 -> {billiard with dim = {img; size = (30.,30.); offset = (650.,250.);}}
    | 14 -> {billiard with dim = {img; size = (30.,30.); offset = (700.,250.);}}
    | 15 -> {billiard with dim = {img; size = (30.,30.); offset = (750.,250.);}}
    | _ -> failwith ""
  else if counter mod 20 > 9 && counter mod 20 < 15
      && ( (sqrt ((fst velocity) ** 2.) +. ((snd velocity) ** 2.)) > spd) then
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
  else
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
    | 8 -> let img = "media/gries.png" in
      {billiard with dim = {img; size = (30.,30.); offset = (0.,0.);}}
    | _ -> let img = "media/easter_egg.png" in
      {billiard with dim = {img; size = (30.,30.); offset = (0.,0.);}}


(*https://developer.mozilla.org/en-US/docs/Web/API
  /CanvasRenderingContext2D/drawImage*)

(* [draw_image context img_src x y] draws the given [img_src]
   string at the x,y [coord] on the canvas' [context]. *)
let draw_image context img_src coord =
  let img = Html.createImg document in
  img##src <- img_src;
  context##drawImage ((img), (fst coord), (snd coord))

(* [draw_helpcontext img_src x y] draws the given [img_src]
   string at the x,y [coord] on the canvas' [context] with
   offset (within the source png) of sx,sy and size of sw,sh*)
let draw_help context (b: billiard) (x, y)=
  let img = Html.createImg document in
  let (sx, sy) = b.dim.offset in
  let (sw, sh) = b.dim.size in
  img##src <- js b.dim.img;
  context##drawImage_full (img, sx, sy, sw, sh, x, y, sw, sh)

(* [draw_billiard context b] draws the billiard on the given context.
   according to the picture chosen above based on its suit and state *)
let draw_billiard (context: Html.canvasRenderingContext2D Js.t)
    (b: billiard) counter egg =
  let suit = b.suit in
  let choose_b = get_ball_img suit b b.velocity counter egg in
  let pos = (fst b.position -. 15., snd b.position -. 15.) in
  draw_help context choose_b pos

(* [draw_billiards] maps the draw_billiard function to a list of billiards*)
let draw_billiards (context: Html.canvasRenderingContext2D Js.t) b_list
    counter egg =
  List.map (fun b -> draw_billiard context b counter egg ) b_list |> ignore

(* [draw_table] draws the pool table *)
let draw_table (context: Html.canvasRenderingContext2D Js.t)
  = draw_image context (js "media/pool_table_sm.png") (0.,0.)

(* [draw_legal_billiards] draws the billiards next to the player profile
   picture to
   denote the current billiards on board it can hit and be rewarded with
   another turn*)
let draw_legal_billiards (context: Html.canvasRenderingContext2D Js.t)
    (b: billiard) (legal_eight: bool) (player: int) (on_board: billiard list)
    egg =
  let s = b.suit in
  if (List.mem b on_board) then
    let p = float_of_int (player - 1) in
    if (s = 0 || s < 0 || s > 15) then draw_help context b (20000.,20000.)
    else if s = 8 && legal_eight then if egg then
        draw_image context (js "media/gries.png")
        ((231. +. 3. *. 45. +. p *. 613. ), (37. +. 22.))
    else
        draw_help context Billiards.eight_ball
        ((231. +. 3. *. 45. +. p *. 613. ), (37. +. 22.))
    else let legal_s = s mod 8 in
      let x = (231 + ((legal_s - 1) mod 4) * 45 + (int_of_float p) * 613) in
      let y = (((legal_s - 1) / 4) * 37 + 22) in
      let choose_b = get_ball_img s b (0.,0.) 0 egg in
      draw_help context choose_b (float_of_int x, float_of_int y)
  else draw_image context (js "media/blank.png") (0., 0.)

(* [draw_stat] calls drwa_legal_billairds and maps it to
   each player's legal billiards list *)
let draw_stat (context: Html.canvasRenderingContext2D Js.t) player p on_board egg =
  let legal_eight = (List.mem eight_ball player.legal_pot) in
  List.map (fun b -> draw_legal_billiards context b legal_eight p on_board egg)
    player.legal_pot |> ignore

(* [draws turn] draws a turn indicator either next ot player 1 or player 2 to
   denote whos turn it is to play and aim.   *)
let draw_turn c p =
  if p then
    draw_image c (js "media/turnp1.png") (231., 7.)
  else
    draw_image c (js "media/turnp2.png") (843., 7.)

(* [draw_debug] displays some dynamic parameters that will be useful for
   bug testing *)
let draw_debug context str y =
  let text = js (str) in
  context##font <- js "10px  ";
  context##fillText (text, 1240., y)

(* [drawing_bearing] displays the current aiming angle of the player's cue *)
let draw_bearing context str =
  let text = js (str) in
  context##font <- js "30px  ";
  context##fillText (text, 20., 171.)

(* [clear canvas] clears the canvas of all drawing. *)
let clear (context: Html.canvasRenderingContext2D Js.t) =
  context##clearRect (0., 0., canvas_width, canvas_height)

(* [draw_rotated] draws the cue and its angle and laser sight in real time
   based on the angle (bearing) of aiming and the gap between the cue tip
   and the cue_ball. Essentially, it saves current elemtns, seets the
   center of rotation to the cue_ball since the pool cue
   is always circled around the cue ball. It rotates the canvas,
   and then draws the pool cue, reverts the canvas (but not the rotated cue)
   and then to adjust offset it is *)
let draw_rotated2 context degrees img bx by gap =
  context##save();
  context##translate(bx, by);
  context##rotate(degrees *. 3.1416926 /. 180.);
  draw_image context (js img) (gap, -1. *. 6.);
  draw_image context
    (js "media/fokn_laser_sight.png") ( -600. , 0.);
  context##restore()

(* [draw_state] ties together all the functions here. it uses state and
   its parameters to display them. *)
let draw_state (context: Html.canvasRenderingContext2D Js.t) state =
  clear context;
  (* draws the table. since everything is on top of the table
  this is the lowest layer*)
  draw_table context;
  if state.is_egg then draw_image context (js "media/cheats.png") (300.,350.)
  else draw_image context (js "media/blank.png") (0.,0.);
  (*draws the current player playing*)
  draw_turn context (state.is_playing = player1);
  (*draws the billiards*)
  draw_billiards context state.on_board state.counter (state.is_egg) ;
  (* chooses the game mode *)
  if state.is_mult then
    draw_image context (js "media/p2.png") (1051.,0.)
  else draw_image context (js "media/blank.png") (0.,0.);
  if state.is_test then
    draw_image context (js "media/ai.png") (100.,0.)
  else draw_image context (js "media/blank.png") (0.,0.);
  (* displays some debug information mainly for the impelmenter *)
  draw_debug context ("cue_ball.pos: (" ^
                      (string_of_float (fst cue_ball.position)) ^ ", " ^
                      (string_of_float (snd cue_ball.position)) ^ ")") 10.;
  draw_debug context ("cue_pos: (" ^
                      (string_of_float (fst state.cue_pos)) ^ ", " ^
                      (string_of_float (snd state.cue_pos)) ^ ")") 22.;
  draw_debug context ("state number: " ^ (string_of_int state.counter)) 34.;
  draw_debug context ("player: " ^ state.is_playing.name) 46.;
  draw_debug context ("ball_moving: " ^ string_of_bool state.ball_moving) 58.;
  draw_debug context ("hit_force: " ^ (string_of_float (fst state.hit_force)) ^ " " ^ (string_of_float (snd state.hit_force))) 70.;
  draw_debug context ("cue: " ^ (string_of_int state.choose_cue)) 82.;
  draw_debug context ("cue: " ^ (string_of_bool state.is_egg)) 94.;
  (* draws the pool cue with regards to the white ball, the bearing, and
     the gap between the cue and the ball *)
  let a1 = fst cue_ball.position in let a2 = snd cue_ball.position in
  let gap = state.gap in let bearing = state.cue_bearing in

  (* updates the GUI to represent the current controls. this includes
     the bearing of the cue, the sight, and all 'tentative' actions
     not yet committed. this is a dynamic representation so it is
     only updated when the ball is not moving, or else the cue will move
     alongside the white ball*)
  if state.ball_moving = false then
    draw_image context (js "media/power_bar.png") (35., 640. -. gap *. 2.3 )
  else
    draw_image context (js "media/empty.png") (0., 0.);

  draw_image context (js "media/left.png") (0., 0.);
  draw_bearing context
    (string_of_float ((float_of_int (int_of_float
                                       (10. *. state.cue_bearing)))/. 10.));
  draw_stat context player1 1 state.on_board (state.is_egg);
  draw_stat context player2 2 state.on_board (state.is_egg);
  if state.choose_cue = 0 then
    if state.ball_moving = false then
      draw_rotated2 context bearing "media/pool_cue.png" a1 a2 gap
    else
      draw_image context (js "media/pool_cue_vert.png") (1170., 150.)
  else if state.choose_cue = 1 then
    if state.ball_moving = false then
      draw_rotated2 context bearing "media/pool_cue1.png" a1 a2 gap
    else
      draw_image context (js "media/pool_cue1_vert.png") (1170., 150.)
  else if state.choose_cue = 2 then
    if state.ball_moving = false then
      draw_rotated2 context bearing "media/pool_cue2.png" a1 a2 gap
    else
      draw_image context (js "media/pool_cue2_vert.png") (1170., 150.)
  else if state.choose_cue = 3 then
    if state.ball_moving = false then
      draw_rotated2 context bearing "media/pool_cue3.png" a1 a2 gap
    else
      draw_image context (js "media/pool_cue3_vert.png") (1170., 150.)
  else
  if state.ball_moving = false then
    draw_rotated2 context bearing "media/pool_cue.png" a1 a2 gap
  else
    draw_image context (js "media/pool_cue_vert.png") (1170., 150.);
  (*these are the topmost layers and as such deal with the game start
    and ending screens (which should cover everything )*)
  if state.is_start then draw_image context (js "media/start.png") ( 0. , 0.)
  else draw_image context (js "media/blank.png") ( 0. , 0.);
  if state.win = 1 then draw_image context (js "media/win.png") ( 0. , 0.)
  else if state.win = 2 then draw_image context (js "media/lose.png") ( 0. , 0.)
  else draw_image context (js "media/blank.png") ( 0. , 0.)
