open OUnit2
open Types
open Billiards
open Player
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
    img = "media/billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "media/billiards.png";
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
    img = "media/billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (50., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "media/billiards.png";
  mass = 10.;
}

let ball_150_150 = {
  suit = 2;
  name = "Ball 150 150" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (150.,150.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "media/billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (50., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "media/billiards.png";
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
    img = "media/billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (50., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "media/billiards.png";
  mass = 10.;
}

let player1 = {
  name = "player_1";
  is_playing = true;
  score = 0;
  cue = 0;
  money = 0;
  legal_pot = one_ball::two_ball::three_ball::four_ball::five_ball::
              six_ball::seven_ball::eight_ball::[];
  default_legal_pot = one_ball::two_ball::three_ball::four_ball::five_ball::
              six_ball::seven_ball::eight_ball::[];
}

let player2 = {
  name = "player_2";
  is_playing = false;
  score = 0;
  cue = 0;
  money = 0;
  legal_pot = nine_ball::ten_ball::eleven_ball::twelve_ball::thirteen_ball::
              fourteen_ball::fifteen_ball::[];
  default_legal_pot = nine_ball::ten_ball::eleven_ball::twelve_ball::
                      thirteen_ball::fourteen_ball::fifteen_ball::[];
}

let billiard_between_list1 = [ball_15_15]
let billiard_between_list2 = [ball_300_10]
let billiard_between_list3 = [ball_150_150]
let billiard_between_list4 = [ball_15_15;ball_300_10;ball_150_150]

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
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
  round = 0;
  prev_ball_moving = false;
  billiards_removed_in_a_round = [];
  is_start = false;
  is_mult = false;
  is_test = false;
}

let player_1_temp = {
  name = "player_1";
  is_playing = true;
  score = 0;
  cue = 0;
  money = 0;
  legal_pot = ball_15_15::[];
  default_legal_pot = ball_15_15::[];
}

let state_test1 = {
  on_board = [cue_ball_temp; ball_15_15];
  player = [player_1_temp];
  cue_bearing = 0. ;
  cue_pos = (0. ,0. );
  is_pot = [];
  foul = No_foul;
  current_table_id = "default";
  is_playing = player2;
  ball_moving = false;
  hit_force = (0.0, 0.0);
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
  round = 0;
  prev_ball_moving = false;
  billiards_removed_in_a_round = [];
  is_start = false;
  is_mult = false;
  is_test = false;
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
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
  round = 0;
  prev_ball_moving = false;
  billiards_removed_in_a_round = [];
  is_start = false;
  is_mult = false;
  is_test = false;
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
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
  round = 0;
  prev_ball_moving = false;
  billiards_removed_in_a_round = [];
  is_start = false;
  is_mult = false;
  is_test = false;
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
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
  round = 0;
  prev_ball_moving = false;
  billiards_removed_in_a_round = [];
  is_start = false;
  is_mult = false;
  is_test = false;
}

let initial_state = {
  on_board = [cue_ball; one_ball; two_ball; three_ball; four_ball; five_ball;
              six_ball; seven_ball; eight_ball; nine_ball; ten_ball;
              eleven_ball; twelve_ball; thirteen_ball; fourteen_ball;
              fifteen_ball;];
  cue_bearing = 20.;
  cue_pos = (805., 290.);
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  counter = 0;
  gap = 0.;
  is_collide = true;
  win = 0;
  round = 0;
  prev_ball_moving = false;
  billiards_removed_in_a_round = [];
  is_start = false;
  is_mult = false;
  is_test = false;
}

let initial_state_cue_ball_changed = {
  on_board = [cue_ball; two_ball; three_ball; four_ball; five_ball;
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
  round = 100;
  billiards_removed_in_a_round = [];
  is_start = false;
  is_mult = false;
  is_test = false;
}

(* -------------- RANDOM STATE TEST -------------- *)

let cue_ball_random1 = {
  suit = 0;
  name = "c" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (600.,400.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  dim = {
    img = "media/billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "media/billiards.png";
  mass = 10.;
}

let b1 = {
  suit = 1;
  name = "c" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (200.,200.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  dim = {
    img = "media/billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "media/billiards.png";
  mass = 10.;
}

let b2 = {
  suit = 2;
  name = "b2" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (250.,500.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  dim = {
    img = "media/billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "media/billiards.png";
  mass = 10.;
}

let b3 = {
  suit = 3;
  name = "b3" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (650.,190.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  dim = {
    img = "media/billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "media/billiards.png";
  mass = 10.;
}

let b4 = {
  suit = 4;
  name = "b4" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (900.,300.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  dim = {
    img = "media/billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "media/billiards.png";
  mass = 10.;
}

let b5 = {
  suit = 5;
  name = "b5" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (900.,450.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  dim = {
    img = "media/billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "media/billiards.png";
  mass = 10.;
}

let b6 = {
  suit = 6;
  name = "b6" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (50.,50.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  dim = {
    img = "media/billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "media/billiards.png";
  mass = 10.;
}

let player1_random1 = {
  name = "player_1";
  is_playing = true;
  score = 0;
  cue = 0;
  money = 0;
  legal_pot = b1::b2::b3::[];
  default_legal_pot = b1::b2::b3::[];
}

let player2_random1 = {
  name = "player_2";
  is_playing = false;
  score = 0;
  cue = 0;
  money = 0;
  legal_pot = b4::b5::b6::[];
  default_legal_pot = b4::b5::b6::[];
}

let state_test_random1 = {
  on_board = cue_ball_random1::b1::b2::b3::b4::b5::b6::[];
  cue_bearing = 0.;
  counter = 0;
  gap = 45.;
  is_collide = false;
  cue_pos = (((fst cue_ball_random1.position) +. 45.),
             (snd cue_ball_random1.position));
  is_pot = [];
  player = [player1_random1; player2_random1];
  ball_moving = false;
  prev_ball_moving = false;
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1_random1;
  hit_force = (0., 0.);
  win = 0;
  round = 100;
  billiards_removed_in_a_round = [];
  is_start = false;
  is_mult = false;
  is_test = false;
}

let tests =
  [
    (*-----------------FUNCTION TEST-----------------*)
    (*billiard_between*)
    "test_billiard_between0" >::
    (fun _ -> assert_equal true
        (billiard_between (0. , 0.) (100., 100.) billiard_between_list1));
    "test_billiard_between1" >::
    (fun _ -> assert_equal false
        (billiard_between (0. , 0.) (100., 100.) billiard_between_list2));
    "test_billiard_between2" >::
    (fun _ -> assert_equal false
        (billiard_between (0. , 0.) (100., 100.) billiard_between_list3));
    "test_billiard_between3" >::
    (fun _ -> assert_equal true
        (billiard_between (0. , 0.) (100., 100.) billiard_between_list4));

    (* search1_possible evaluation *)
    (* No billiards on table *)
    "search1_possible_test0" >::
    (fun _ -> assert_equal 1
        (try search1_possible state_test_no_billiard with _ -> 1));
    (* 1 billiard on table *)
    "search1_possible_test1" >::
    (fun _ -> assert_equal 0 (search1_possible state_test1));
    (* 2 billiards on table *)
    "search1_possible_test2" >::
    (fun _ -> assert_equal 0 (search1_possible state_test2));
    (* state_test_random1 *)
    "search1_possible_test3" >::
    (fun _ -> assert_equal 2 (search1_possible state_test_random1));

    (* closest_billiard *)
    "search1_possible_test2" >::
    (fun _ -> assert_equal (300., 50.)
        (closest_billiard cue_ball_random1.position player2_random1.legal_pot
           (2000., 2000.)));

    (* Search 1 calculation *)
    (* pot upper left *)
    "search1_calculation1" >::
    (fun _ -> assert_equal
        (-863.603896932107205, -863.603896932107205)
        (search1_calculation (250., 250.) (200., 200.) []));
    (* pot upper left *)
    "search1_calculation2" >::
    (fun _ -> assert_equal
        (-2715.39501058484575, -646.185031754537249)
        (search1_calculation (300., 300.) (200., 250.) []));
    (* pot upper middle *)
    "search1_calculation3" >::
    (fun _ -> assert_equal
        (2768.10361449569973, -2130.38855435887763)
        (search1_calculation (500., 350.) (600., 250.) []));
    (* pot upper right *)
    "search1_calculation4" >::
    (fun _ -> assert_equal
        (3000., -705.03216089298337)
        (search1_calculation (500., 350.) (900., 250.) []));
    (* pot lower right *)
    "search1_calculation5" >::
    (fun _ -> assert_equal
        (3000., 1538.3007713317611)
        (search1_calculation (500., 350.) (900., 550.) []));
    (* pot lower middle *)
    "search1_calculation6" >::
    (fun _ -> assert_equal
        (-2127.36802173926026, 1809.16997020531312)
        (search1_calculation (800., 350.) (700., 450.) []));
    (* pot lower left *)
    "search1_calculation6" >::
    (fun _ -> assert_equal
        (-3000., 1193.02676961055568)
        (search1_calculation (800., 350.) (300., 550.) []));

    (*-----------------GENERAL STATE TEST-----------------*)
    (* AI first round, hit with huge force *)
    "test_initial_state" >::
    (fun _ -> assert_equal (-14820., 450.)
        (ai_evaluate_next_move initial_state));
    "test_initial_state_changed" >::
    (fun _ -> assert_equal (-3000., -131.814199045586861)
        (ai_evaluate_next_move initial_state_cue_ball_changed));
    "test_state_test_random1" >::
    (fun _ -> assert_equal (-3000., -244.056389985511174)
        (ai_evaluate_next_move state_test_random1));

  ]

let suite =
  "Billiard ai test suite"
  >::: tests

let _ = run_test_tt_main suite
