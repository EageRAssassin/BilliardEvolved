open OUnit2
open Types
open State

let player1 = {
  name = "player";
  is_playing = false;
  score = 0;
  cue = 0;
  money = 0;
}

let player2 = {
  name = "AI";
  is_playing = true;
  score = 0;
  cue = 0;
  money = 0;
}

let cue_ball = {
  suit = 0;
  name = "Cue Ball" ;
  size = (25.,25.);
  velocity = (-500.,500.);
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

let state_cue_moving = {
  on_board = [cue_ball];
  player = [player1; player2];
  cue_bearing = 0.;
  cue_pos = (0.,0.);
  is_pot = [];
  foul = No_foul;
  current_table_id = "default";
  is_playing = player2;
  ball_moving = false;
  hit_force = (0.0, 0.0);
  player_aiming = false;
}

let collide_ball1 = {
  suit = 0;
  name = "collide_ball1" ;
  size = (25.,25.);
  velocity = (500.,500.);
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

let collide_ball2 = {
  suit = 0;
  name = "collide_ball2" ;
  size = (25.,25.);
  velocity = (-500.,-500.);
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

let state_ball_collide = {
  on_board = [collide_ball1;collide_ball2];
  player = [player1; player2];
  cue_bearing = 0.;
  cue_pos = (0.,0.);
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

    (* "test_billiard_between0" >:: (fun _ -> assert_equal true ( (0. , 0.) (100., 100.) billiard_between_list1)); *)
    (* change_state state_cue_moving *)
  ]

let suite =
  "Billiard test suite"
  >::: tests

let _ = run_test_tt_main suite
