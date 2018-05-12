open Types
open Command
open Billiards
open Player
(* open State *)

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(* initial state *)
let initial_state = {
  on_board = [cue_ball;one_ball;two_ball; three_ball; four_ball; five_ball;
                 six_ball; seven_ball; eight_ball; nine_ball; ten_ball; eleven_ball; twelve_ball;
              thirteen_ball; fourteen_ball; fifteen_ball;];
  cue_bearing = 0.;
  counter = 0;
  gap = 45.;
  is_collide = false;
  cue_pos = (((fst cue_ball.position) +. 45.), (snd cue_ball.position));
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  prev_ball_moving = false;
  (* if we use multiple skins *)
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  player_aiming = false;
  win = 0;
  round = 0;
  (* all_tables = [Tables.default] *)
}

(* mutable ref to store the current game state *)
let state = ref (initial_state)

(*controls*)
(* mutable ref to store the current game state *)
let state = ref (initial_state)

(*https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
  https://www.w3schools.com/charsets/ref_utf_basic_latin.asp
*)
let keydown event =
  let new_state = State.change_state !state in
  let () = match event##keyCode with
    | 87 -> player_command.w <- true; state := new_state
    | 65 -> player_command.a <- true; state := new_state
    | 83 -> player_command.s <- true; state := new_state
    | 68 -> player_command.d <- true; state := new_state
    | 74 -> player_command.j <- true; state := new_state
    | 81 -> player_command.q <- true; state := new_state
    | 69 -> player_command.e <- true; state := new_state
    | 50 -> player_command.two <- true; state := new_state
    | 88 -> player_command.x <- true; state := new_state

    | _ -> player_command.w <- true; state := new_state (* other *)
  in Js._true

let keyup event =
  let new_state = State.change_state !state in
  let () = match event##keyCode with
    | 87 -> player_command.w <- false; state := new_state
    | 65 -> player_command.a <- false; state := new_state
    | 83 -> player_command.s <- false; state := new_state
    | 68 -> player_command.d <- false; state := new_state
    | 74 -> player_command.j <- false; state := new_state
    | 81 -> player_command.q <- false; state := new_state
    | 69 -> player_command.e <- false; state := new_state
    | 50 -> player_command.two <- false; state := new_state
    | 88 -> player_command.x <- false; state := new_state

    | _ -> player_command.w <- false; state := new_state (* other *)
  in Js._true

(* https://www.w3schools.com/jsref/dom_obj_event.asp
   and Oxcigen's doc
   https://ocsigen.org/js_of_ocaml/2.5/api/Dom_html
*)

let mousemove (event : Dom_html.mouseEvent Js.t) =
  let new_state = State.change_state !state in
  let () = match event##clientX, event##clientY with
    | (x,y) ->
      player_command.cue_coord <- (float_of_int x, float_of_int y);
      (* player_command.cue_bearing <- *)
      state := new_state in
  Js._true

let mousedown (event : Dom_html.mouseEvent Js.t) =
  let new_state = State.change_state !state in
  let () = match event##button with
    | 0 ->
      let audio = Html.createAudio document in
      audio##src <- js "media/cue.mp3";
      audio##play ();
      player_command.cue_release <- true;
    state := new_state
    | _ -> player_command.cue_release <- false; state := new_state
in Js._true

let mouseup (event : Dom_html.mouseEvent Js.t) =
  let new_state = State.change_state !state in
  let () = match event##button with
    | 0 -> player_command.cue_release <- false; state := new_state
    | _ -> player_command.cue_release <- false; state := new_state
in Js._true

(* the main game loop modify this later*)
let game_loop context has_won =
  let rec game_loop_helper () =
    state := State.change_state !state;
    Gui.draw_state context !state;
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper ())
    ) |> ignore
  in game_loop_helper ()

(*shoddy implementation, may not work*)
(* let game_loop context has_won = game_loop_helper context has_won *)
