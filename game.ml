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
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  (* all_tables = [Tables.default] *)
}

(* mutable ref to store the current game state *)
let state = ref (initial_state)

let keydown event =
  let () = match event##keyCode with
    | 87 -> player_command.w <- true; state := State.change_state !state
    | 65 -> player_command.a <- true; state := State.change_state !state
    | 83 -> player_command.s <- true; state := State.change_state !state
    | 68 -> player_command.d <- true; state := State.change_state !state
    | _ -> () (* other *)
  in Js._true

let keyup event =
  let () = match event##keyCode with
    | 87 -> player_command.w <- false; state := State.change_state !state
    | 65 -> player_command.a <- false; state := State.change_state !state
    | 83 -> player_command.s <- false; state := State.change_state !state
    | 68 -> player_command.d <- false; state := State.change_state !state
    | _ -> () (* other *)
  in Js._true

(* the main game loop *)
let game_loop context has_won =
  let rec game_loop_helper () =
    state := State.change_state !state;
    Gui.draw_state context !state;
    Html.window##requestAnimationFrame(
      Js.wrap_callback (fun (t:float) -> game_loop_helper ())
    ) |> ignore
  in game_loop_helper ()
