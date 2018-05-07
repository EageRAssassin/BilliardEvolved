open Types
open Command
open Billiards
open Player

(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(* initial state *)
let initial_state = {
  on_board = [cue_ball; one_ball; two_ball; three_ball; four_ball; five_ball;
                 six_ball; seven_ball; eight_ball; nine_ball; ten_ball; eleven_ball; twelve_ball;
              thirteen_ball; fourteen_ball; fifteen_ball];
  cue_bearing = 0.;
  cue_pos = (820., 289.);
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  (* if we use multiple skins *)
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  player_aiming = true;
  (* all_tables = [Tables.default] *)
}

(* mutable ref to store the current game state *)
let state = ref (initial_state)

(*controls*)

(* the main game loop modify this later*)
let game_loop context has_won =
  let rec game_loop_helper () =
    state := State.change_state !state;
    Gui.draw_state context !state;
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper ())
    ) |> ignore
  in game_loop_helper ()


(*
(* the main game loop *)
let rec game_loop_helper context has_won =
    state := State.change_state !state;
    Gui.draw_state context !state;
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper context has_won)
    ) |> ignore

(*shoddy implementation, may not work*)
let game_loop context has_won = game_loop_helper context has_won *)
