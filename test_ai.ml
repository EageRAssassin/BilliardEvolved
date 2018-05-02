open OUnit2
open Types
open Ai

let cue_ball = {
  suit = 0;
  name = "Cue Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (50.,50.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "billiards.png";
  mass = 10.;
}

let ball_15_15 = {
  suit = 1;
  name = "Ball 15 15" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (15.,15.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (50., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let ball_150_150 = {
  suit = 1;
  name = "Ball 150 150" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (150.,150.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (50., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let ball_300_10 = {
  suit = 1;
  name = "Ball 300 10" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (300.,10.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (50., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let billiard_between_list1 = [ball_15_15]
let billiard_between_list2 = [ball_300_10]

let player1 = {
  is_playing = false;
  score = 0;
  cue = 0;
  money = 0;
}

let player2 = {
  is_playing = true;
  score = 0;
  cue = 0;
  money = 0;
}

let state_test_no_billiard = {
  on_board = [cue_ball];
  player = [player1; player2];
  is_pot = [];
  foul = No_foul;
  current_table_id = "default";
  is_playing = player2;
  ball_moving = false;
  hit_force = (0.0, 0.0);
  player_aiming = false;
}

let state_test1 = {
  on_board = [cue_ball; ball_15_15];
  player = [player1; player2];
  is_pot = [];
  foul = No_foul;
  current_table_id = "default";
  is_playing = player2;
  ball_moving = false;
  hit_force = (0.0, 0.0);
  player_aiming = false;
}

let state_test2 = {
  on_board = [cue_ball; ball_150_150; ball_15_15];
  player = [player1; player2];
  is_pot = [];
  foul = No_foul;
  current_table_id = "default";
  is_playing = player2;
  ball_moving = false;
  hit_force = (0.0, 0.0);
  player_aiming = false;
}


let tests =
  [
    (* Only 2 balls present *)
    (* "test0" >:: (fun _ -> assert_equal (0., 0.) (ai_evaluate_next_move state_test0)); *)
    "test0" >:: (fun _ -> assert_equal 1 (try search1_possible state_test_no_billiard with _ -> 1));
    "test1" >:: (fun _ -> assert_equal 0 (search1_possible state_test1));
    (* "test2" >:: (fun _ -> assert_equal 1 (search1_possible state_test2)); *)
    "test_billiard_between0" >:: (fun _ -> assert_equal true (billiard_between (0. , 0.) (100., 100.) billiard_between_list1));
    "test_billiard_between1" >:: (fun _ -> assert_equal false (billiard_between (0. , 0.) (100., 100.) billiard_between_list2));

  ]

let suite =
  "Billiard test suite"
  >::: tests

let _ = run_test_tt_main suite
