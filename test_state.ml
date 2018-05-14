open OUnit2
open Types
open Billiards
open Player

(* WE COPIED THE FUNCTIONS FROM STATE AS OCAML DOES NOT ALLOW US TO USE
   OUNIT2 AND JS_OF_OCAML AT THE SAME TIME *)
let rec find_next_player (players : player list) (is_playing : player) =
  match players with
  | [] -> failwith "player not found"
  | h :: t -> if h = is_playing
    then find_next_player t is_playing else h

let rec hit_legal_plot_ball ball_removed legalpot=
  match ball_removed with
  | x::xs -> if List.mem x legalpot
    then true else hit_legal_plot_ball xs legalpot
  | [] -> false

let rec contain_cue_ball billiards =
  match billiards with
  | x::xs -> if (x.suit = 0) then true
    else contain_cue_ball xs
  | []-> false

let rec contain_8_ball_undone billiards player_target_balls=
  match billiards with
  | x::xs -> if (x.suit = 8 ) && (player_target_balls <>[] ) then true
    else contain_8_ball_undone xs player_target_balls
  | []-> false

let next_round (st : state) =
  let players = st.player in
  let current_player = st.is_playing in
  let another_player = find_next_player players current_player in
  (* let current_legal_pot = current_player.legal_pot in
  *)
  (* let balls_on_board = st.on_board in *)
  (* if (current_legal_pot=[] && List.mem Billiards.eight_ball balls_on_board)
     then current_player.legal_pot <- [Billiards.eight_ball];
     if (another_player.legal_pot=[] && List.mem Billiards.eight_ball balls_on_board)
     then another_player.legal_pot <- [Billiards.eight_ball]; *)

  let billiards_to_be_removed = st.billiards_removed_in_a_round in
  if current_player.legal_pot = [] &&
     List.mem Billiards.eight_ball billiards_to_be_removed then
    if current_player.name = "player_1"
    then st.win <- 1
    else st.win <- 2
  else
    (*not hit balls in the legal pot*)
  if not (hit_legal_plot_ball billiards_to_be_removed
            current_player.default_legal_pot) then
    begin
      current_player.is_playing <- false;
      another_player.is_playing <- true;
      st.is_playing <- another_player;
      st.round <- st.round + 1;
    end
    (*white ball in cue*)
  else if contain_cue_ball billiards_to_be_removed then
    begin
      current_player.is_playing <- false;
      another_player.is_playing <- true;
      st.is_playing <- another_player;
      st.foul <- Cue_pot;
      st.round <- st.round + 1;
    end
    (*while ball eight is not in the legal list, hit the 8 ball in it*)
  else if (contain_8_ball_undone billiards_to_be_removed
             current_player.default_legal_pot) then
    if current_player.name = "player_1"
    then begin
      st.win <- 2;
      current_player.is_playing <- false;
      another_player.is_playing <- true;
      st.foul <- Cue_eight;
    end
    else begin
      st.win <- 1;
      current_player.is_playing <- false;
      another_player.is_playing <- true;
      st.foul <- Cue_eight;
    end;
    st

(* initial state *)
let initial_state = {
  on_board = [cue_ball;one_ball;two_ball; three_ball; four_ball; five_ball;
              six_ball; seven_ball; eight_ball; nine_ball; ten_ball;
              eleven_ball; twelve_ball; thirteen_ball; fourteen_ball;
              fifteen_ball;];
  cue_bearing = 0.;
  counter = 0;
  gap = 45.;
  is_collide = false;
  cue_pos = (((fst cue_ball.position) +. 45.), (snd cue_ball.position));
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  prev_ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  win = 0;
  round = 0;
  billiards_removed_in_a_round = [];
  is_start = true;
  is_mult = false;
  is_test = false;
}

(* apply next round to initial_state *)
let initial_state_next_round = next_round initial_state

(* end game state *)
let end_game_state = {
  on_board = [cue_ball; one_ball; eight_ball; fifteen_ball;];
  cue_bearing = 0.;
  counter = 0;
  gap = 45.;
  is_collide = false;
  cue_pos = (((fst cue_ball.position) +. 45.), (snd cue_ball.position));
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  prev_ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  win = 0;
  round = 3110;
  billiards_removed_in_a_round = [];
  is_start = true;
  is_mult = false;
  is_test = false;
}

(* apply next round to end_game_state *)
let end_game_state_next_round = next_round end_game_state

(* end game state 2 *)
(* player1 got 1 ball and 15 ball in, need to hit in 8 ball *)
let end_game_state2 = {
  on_board = [cue_ball; eight_ball; fifteen_ball;];
  cue_bearing = 0.;
  counter = 0;
  gap = 45.;
  is_collide = false;
  cue_pos = (((fst cue_ball.position) +. 45.), (snd cue_ball.position));
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  prev_ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  win = 0;
  round = 4110;
  billiards_removed_in_a_round = [one_ball];
  is_start = true;
  is_mult = false;
  is_test = false;
}

(* apply next round to end_game_state *)
let end_game_state2_next_round = next_round end_game_state2


(* end game state 3 *)
(* player1 got 1 ball and 15 ball in, need to hit in 8 ball *)
let end_game_state3 = {
  on_board = [cue_ball; eight_ball;];
  cue_bearing = 0.;
  counter = 0;
  gap = 45.;
  is_collide = false;
  cue_pos = (((fst cue_ball.position) +. 45.), (snd cue_ball.position));
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  prev_ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  win = 0;
  round = 4110;
  billiards_removed_in_a_round = [one_ball; fifteen_ball];
  is_start = true;
  is_mult = false;
  is_test = false;
}

(* apply next round to end_game_state *)
let end_game_state3_next_round = next_round end_game_state3


(* end game state 4 *)
(* player1 got 8 ball in, loses as the rule states. Should hit 8 at the end *)
let end_game_state4 = {
  on_board = [cue_ball; one_ball; fifteen_ball];
  cue_bearing = 0.;
  counter = 0;
  gap = 45.;
  is_collide = false;
  cue_pos = (((fst cue_ball.position) +. 45.), (snd cue_ball.position));
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  prev_ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  win = 0;
  round = 5110;
  billiards_removed_in_a_round = [eight_ball];
  is_start = true;
  is_mult = false;
  is_test = false;
}

let () = player1.default_legal_pot <-
    Billiards.eight_ball :: player1.default_legal_pot

let () = player2.default_legal_pot <-
    Billiards.eight_ball :: player2.default_legal_pot

(* apply next round to end_game_state *)
let end_game_state4_next_round = next_round end_game_state4


(* cue_ball_foul state *)
(* player1 got cue ball in, change player *)
let cue_ball_foul_state = {
  on_board = [one_ball; eight_ball; fifteen_ball];
  cue_bearing = 0.;
  counter = 0;
  gap = 45.;
  is_collide = false;
  cue_pos = (((fst cue_ball.position) +. 45.), (snd cue_ball.position));
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  prev_ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  win = 0;
  round = 4820;
  billiards_removed_in_a_round = [two_ball; cue_ball];
  is_start = true;
  is_mult = false;
  is_test = false;
}
(* apply next round to cue_ball_foul_state *)
let cue_ball_foul_state_next_round = next_round cue_ball_foul_state

let tests =
  [
    (*-----------------FUNCTION TEST-----------------*)
    (*initialization check*)
    "test_onboard_length" >::
    (fun _ -> assert_equal 16 (List.length initial_state.on_board));
    (* initial state next round check*)
    (* player 1 does not hit any ball*)

    (* no one wins *)
    "test_win" >::
    (fun _ -> assert_equal 0 (initial_state_next_round.win));
    (* nothing in pot *)
    "test_pot" >::
    (fun _ -> assert_equal 0 (List.length initial_state_next_round.is_pot));
    (* no balls moving *)
    "test_ball_moving" >::
    (fun _ -> assert_equal false (initial_state_next_round.ball_moving));
    (* no balls moving in previous state *)
    "test_prev_ball_moving" >::
    (fun _ -> assert_equal false (initial_state_next_round.prev_ball_moving));
    (* player changed to player2 *)
    "test_is_playing" >::
    (fun _ -> assert_equal player2 (initial_state_next_round.is_playing));
    (* no foul *)
    "test_foul" >::
    (fun _ -> assert_equal No_foul (initial_state_next_round.foul));
    (* nothing removed in this round *)
    "test_billiards_removed_in_a_round" >::
    (fun _ -> assert_equal 0
        (List.length initial_state_next_round.billiards_removed_in_a_round));
    (* round number changed to 1 *)
    "test_round" >::
    (fun _ -> assert_equal 1 (initial_state_next_round.round));

    (* end_game_state next round check *)
    (* player 1 does not hit any ball *)
    (* no one wins *)
    "test_win" >::
    (fun _ -> assert_equal 0 (end_game_state_next_round.win));
    (* nothing in pot *)
    "test_pot" >::
    (fun _ -> assert_equal 0 (List.length end_game_state_next_round.is_pot));
    (* no balls moving *)
    "test_ball_moving" >::
    (fun _ -> assert_equal false (end_game_state_next_round.ball_moving));
    (* no balls moving in previous state *)
    "test_prev_ball_moving" >::
    (fun _ -> assert_equal false (end_game_state_next_round.prev_ball_moving));
    (* player changed to player2 *)
    "test_is_playing" >::
    (fun _ -> assert_equal player2 (end_game_state_next_round.is_playing));
    (* no foul *)
    "test_foul" >::
    (fun _ -> assert_equal No_foul (end_game_state_next_round.foul));
    (* nothing removed in this round *)
    "test_billiards_removed_in_a_round" >::
    (fun _ -> assert_equal 0
        (List.length end_game_state_next_round.billiards_removed_in_a_round));
    (* round number changed to 3111 *)
    "test_round" >::
    (fun _ -> assert_equal 3111 (end_game_state_next_round.round));

    (* end_game_state2 next round check *)
    (* player 1 hit ball 1 in, continue playing *)
    (* no one wins *)
    "test_win" >::
    (fun _ -> assert_equal 0 (end_game_state2_next_round.win));
    (* nothing in pot *)
    "test_pot" >::
    (fun _ -> assert_equal 0 (List.length end_game_state2_next_round.is_pot));
    (* no balls moving *)
    "test_ball_moving" >::
    (fun _ -> assert_equal false (end_game_state2_next_round.ball_moving));
    (* no balls moving in previous state *)
    "test_prev_ball_moving" >::
    (fun _ -> assert_equal false (end_game_state2_next_round.prev_ball_moving));
    (* player remains player1 *)
    "test_is_playing" >::
    (fun _ -> assert_equal player1 (end_game_state2_next_round.is_playing));
    (* no foul *)
    "test_foul" >::
    (fun _ -> assert_equal No_foul (end_game_state2_next_round.foul));
    (* ball 1 removed in this round *)
    "test_billiards_removed_in_a_round" >::
    (fun _ -> assert_equal 1
        (List.length end_game_state2_next_round.billiards_removed_in_a_round));
    (* round number changed to 4110, because player does not change *)
    "test_round" >::
    (fun _ -> assert_equal 4110 (end_game_state2_next_round.round));

    (* end_game_state3 next round check *)
    (* player 1 hit ball 1 and ball 15 in, continue playing *)
    (* no one wins *)
    "test_win" >::
    (fun _ -> assert_equal 0 (end_game_state3_next_round.win));
    (* nothing in pot *)
    "test_pot" >::
    (fun _ -> assert_equal 0 (List.length end_game_state3_next_round.is_pot));
    (* no balls moving *)
    "test_ball_moving" >::
    (fun _ -> assert_equal false (end_game_state3_next_round.ball_moving));
    (* no balls moving in previous state *)
    "test_prev_ball_moving" >::
    (fun _ -> assert_equal false (end_game_state3_next_round.prev_ball_moving));
    (* player remains player1 *)
    "test_is_playing" >::
    (fun _ -> assert_equal player1 (end_game_state3_next_round.is_playing));
    (* no foul *)
    "test_foul" >::
    (fun _ -> assert_equal No_foul (end_game_state3_next_round.foul));
    (* ball 1 removed in this round *)
    "test_billiards_removed_in_a_round" >::
    (fun _ -> assert_equal 2 (List.length end_game_state3_next_round.billiards_removed_in_a_round));
    (* round number changed to 4110, because player does not change *)
    "test_round" >::
    (fun _ -> assert_equal 4110 (end_game_state3_next_round.round));

    (* end_game_state4 next round check *)
    (* player 1 hit ball 8 in, loses *)
    (* player 2 wins *)
    "test_win" >::
    (fun _ -> assert_equal 2 (end_game_state4_next_round.win));
    (* player1's foul is Cue_eight *)
    "test_foul" >::
    (fun _ -> assert_equal Cue_eight (end_game_state4_next_round.foul));


    (* end_game_state3 next round check *)
    (* player 1 hit ball 1 and ball 15 in, continue playing *)
    (* no one wins *)
    "test_win" >::
    (fun _ -> assert_equal 0 (cue_ball_foul_state_next_round.win));
    (* nothing in pot *)
    "test_pot" >::
    (fun _ -> assert_equal 0 (List.length cue_ball_foul_state_next_round.is_pot));
    (* no balls moving *)
    "test_ball_moving" >::
    (fun _ -> assert_equal false (cue_ball_foul_state_next_round.ball_moving));
    (* no balls moving in previous state *)
    "test_prev_ball_moving" >::
    (fun _ -> assert_equal false (cue_ball_foul_state_next_round.prev_ball_moving));
    (* player changes to player2 *)
    "test_is_playing" >::
    (fun _ -> assert_equal player2 (cue_ball_foul_state_next_round.is_playing));
    (* no foul *)
    "test_foul" >::
    (fun _ -> assert_equal Cue_pot (cue_ball_foul_state_next_round.foul));
    (* ball 1 removed in this round *)
    "test_billiards_removed_in_a_round" >::
    (fun _ -> assert_equal 2 (List.length cue_ball_foul_state_next_round.billiards_removed_in_a_round));
    (* round number changed to 4110, because player does not change *)
    "test_round" >::
    (fun _ -> assert_equal 4821 (cue_ball_foul_state_next_round.round));

  ]

let suite =
  "Billiard ai test suite"
  >::: tests

let _ = run_test_tt_main suite
