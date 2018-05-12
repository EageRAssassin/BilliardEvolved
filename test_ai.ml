open OUnit2
open Types
open Billiards
open Ai

let cue_ball_temp = {
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
let billiard_between_list3 = [ball_150_150]
let billiard_between_list4 = [ball_15_15;ball_300_10;ball_150_150]

let player1 = {
  name = "player1";
  is_playing = false;
  score = 0;
  cue = 0;
  money = 0;
}

let player2 = {
  name = "player2";
  is_playing = true;
  score = 0;
  cue = 0;
  money = 0;
}

let state_test_no_billiard = {
  on_board = [cue_ball_temp];
  player = [player1; player2];
  cue_bearing = 0. ;
  cue_pos = (0. ,0. );
  is_pot = [];
  foul = No_foul;
  current_table_id = "default";
  is_playing = player2;
  ball_moving = false;
  hit_force = (0.0, 0.0);
  player_aiming = false;
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
}

let state_test1 = {
  on_board = [cue_ball_temp; ball_15_15];
  player = [player1; player2];
  cue_bearing = 0. ;
  cue_pos = (0. ,0. );
  is_pot = [];
  foul = No_foul;
  current_table_id = "default";
  is_playing = player2;
  ball_moving = false;
  hit_force = (0.0, 0.0);
  player_aiming = false;
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
}

let state_test2 = {
  on_board = [cue_ball_temp; ball_150_150; ball_15_15];
  player = [player1; player2];
  cue_bearing = 0. ;
  cue_pos = (0. ,0. );
  is_pot = [];
  foul = No_foul;
  current_table_id = "default";
  is_playing = player2;
  ball_moving = false;
  hit_force = (0.0, 0.0);
  player_aiming = false;
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
}

let state_test3 = {
  on_board = [cue_ball_temp; ball_150_150; ball_15_15];
  player = [player1; player2];
  cue_bearing = 0. ;
  cue_pos = (0. ,0. );
  is_pot = [];
  foul = No_foul;
  current_table_id = "default";
  is_playing = player2;
  ball_moving = false;
  hit_force = (0.0, 0.0);
  player_aiming = false;
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
}

let state_test_closest_billiard = {
  on_board = [cue_ball; one_ball;];
  cue_bearing = 20.;
  cue_pos = (805., 290.);
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  (* if we use multiple skins *)
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  player_aiming = false;
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
}

let initial_state = {
  on_board = [cue_ball; one_ball; two_ball; three_ball; four_ball; five_ball;
              six_ball; seven_ball; eight_ball; nine_ball; ten_ball; eleven_ball; twelve_ball;
              thirteen_ball; fourteen_ball; fifteen_ball;];
  cue_bearing = 20.;
  cue_pos = (805., 290.);
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  player_aiming = false;
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
}

let tests =
  [
    (*-----------------FUNCTION TEST-----------------*)
    "test_billiard_between0" >:: (fun _ -> assert_equal true (billiard_between (0. , 0.) (100., 100.) billiard_between_list1));
    "test_billiard_between1" >:: (fun _ -> assert_equal false (billiard_between (0. , 0.) (100., 100.) billiard_between_list2));
    "test_billiard_between2" >:: (fun _ -> assert_equal false (billiard_between (0. , 0.) (100., 100.) billiard_between_list3));
    "test_billiard_between3" >:: (fun _ -> assert_equal true (billiard_between (0. , 0.) (100., 100.) billiard_between_list4));
    (* Only 2 balls present *)
    (* "test0" >:: (fun _ -> assert_equal (0., 0.) (ai_evaluate_next_move state_test0)); *)
    "test0" >:: (fun _ -> assert_equal 1 (try search1_possible state_test_no_billiard with _ -> 1));
    "test1" >:: (fun _ -> assert_equal 0 (search1_possible state_test1));
    "test2" >:: (fun _ -> assert_equal 1 (search1_possible state_test2));
    (* "test3" >:: (fun _ -> assert_equal 1 (search2_possible state_test2)); *)

    (* Search 1 calculation *)
    "search1_calculation" >:: (fun _ -> assert_equal (1995.80398915498085, 1495.80398915498085) (search1_calculation (50., 100.) (150., 150.)));
    (* "search1_calculation" >:: (fun _ -> assert_equal (997.530822208278778, 997.530822208278778) (search1_calculation (250., 250.) (200., 200.))); *)
    (* (300., 300.) (200., 250.) *)

    (*-----------------GENERAL STATE TEST-----------------*)
    (* initial state: all balls on board. Should hit directly with full force *)
    "initial_state" >:: (fun _ -> assert_equal (-2340., 0.) (ai_evaluate_next_move initial_state));

    (* "test_initial_state" >:: (fun _ -> assert_equal 1 (search1_possible state_test2)); *)

  ]

let suite =
  "Billiard test suite"
  >::: tests

let _ = run_test_tt_main suite
