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

  (* on_board = [cue_ball; one_ball; eight_ball; nine_ball;]; *)
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
  win = 0;
  round = 0;
  (* all_tables = [Tables.default] *)
  billiards_removed_in_a_round = [];
  is_start = true;
  is_mult = false;
  is_test = false;
  choose_cue = 0;
  choose_table = 0;
  is_egg = false;
  (* is_hit = false; *)

}

(* mutable ref to store the current game state *)
let state = ref (initial_state)

(*controls*)
(* mutable ref to store the current game state *)
let state = ref (initial_state)

(*https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
  https://www.w3schools.com/charsets/ref_utf_basic_latin.asp

  mapping uses ocsigen's type declarations
  code (keycode, mouse click) uses HTML's event listener
*)
let keydown event =
  let new_state = State.change_state !state in
  let () = match event##keyCode with
    | 87 -> player_command.w <- true; state := new_state
    | 65 -> player_command.egg_counter <- player_command.egg_counter - 4; state := new_state
    | 83 -> player_command.s <- true; state := new_state
    | 68 -> player_command.d <- true; state := new_state
    | 74 -> player_command.j <- true; state := new_state
    | 81 -> player_command.q <- true; state := new_state
    | 69 -> player_command.e <- true; state := new_state
    | 67 -> player_command.egg_counter <- player_command.egg_counter * 10; state := new_state
    | 79 -> player_command.egg_counter <- 1; state := new_state
    | 77 -> player_command.egg_counter <- player_command.egg_counter * 8; state := new_state
    | 76 -> player_command.egg_counter <- player_command.egg_counter - 6; state := new_state
    | 48 -> player_command.cue <- 0; state := new_state
    | 49 -> player_command.cue <- 1; state := new_state
    | 50 -> player_command.cue <- 2; state := new_state
    | 51 -> player_command.cue <- 3; state := new_state
    | 52 -> player_command.cue <- 4; state := new_state
    | 53 -> player_command.cue <- 5; state := new_state
    | 54 -> player_command.cue <- 6; state := new_state
    | 55 -> player_command.cue <- 7; state := new_state
    | 56 -> player_command.cue <- 8; state := new_state
    | 57 -> player_command.cue <- 9; state := new_state
    | 88 -> player_command.x <- true; state := new_state

    | _ -> player_command.d <- false; state := new_state (* null *)
  in Js._true

let keyup event =
  let new_state = State.change_state !state in
  let () = match event##keyCode with
    | 87 -> player_command.w <- false; state := new_state
    | 65 -> player_command.egg_counter <- player_command.egg_counter; state := new_state
    | 83 -> player_command.s <- false; state := new_state
    | 68 -> player_command.d <- false; state := new_state
    | 74 -> player_command.j <- false; state := new_state
    | 81 -> player_command.q <- false; state := new_state
    | 69 -> player_command.e <- false; state := new_state
    | 67 -> player_command.egg_counter <- player_command.egg_counter; state := new_state
    | 79 -> player_command.egg_counter <- player_command.egg_counter; state := new_state
    | 77 -> player_command.egg_counter <- player_command.egg_counter; state := new_state
    | 76 -> player_command.egg_counter <- player_command.egg_counter; state := new_state
    | 48 -> player_command.cue <- 0; state := new_state
    | 49 -> player_command.cue <- 1; state := new_state
    | 50 -> player_command.cue <- 2; state := new_state
    | 51 -> player_command.cue <- 3; state := new_state
    | 52 -> player_command.cue <- 4; state := new_state
    | 53 -> player_command.cue <- 5; state := new_state
    | 54 -> player_command.cue <- 6; state := new_state
    | 55 -> player_command.cue <- 7; state := new_state
    | 56 -> player_command.cue <- 8; state := new_state
    | 57 -> player_command.cue <- 9; state := new_state
    | 88 -> player_command.x <- false; state := new_state

    | _ -> player_command.d <- false; state := new_state (*null*)
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
      (* let audio = Html.createAudio document in
      audio##src <- js "media/cue.mp3";
      audio##play (); *)
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

(* the main game loop. takes inspiration from Oxcigen's demos *)
let game_loop context has_won =
  let rec game_loop_helper () =
    state := State.change_state !state;
    Gui.draw_state context !state;
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper ())
    ) |> ignore
  in game_loop_helper ()
