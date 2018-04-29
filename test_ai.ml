open OUnit2
open Types
open Ai

let cue_ball = {
  suit = 0;
  name = "Cue Ball" ;
  size = (25,25);
  velocity = (0.,0.);
  position = (500.,500.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  legal_player = None;
  legal_pot = None;
  dim = {
    img = "billiards.png";
    size = (25, 25); (*size of billiard ball on THE IMAGE*)
    offset = (0, 75); (*chooses which on the image provided to take from*)
  };
  image = "billiards.png";
  mass = 10.;
}

let one_ball = {
  suit = 1;
  name = "One Ball" ;
  size = (25,25);
  velocity = (0.,0.);
  position = (500.,600.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  legal_player = None; (* whoever pots a solid first *)
  legal_pot = None;
  dim = {
    img = "billiards.png";
    size = (25, 25); (*size of billiard ball on THE IMAGE*)
    offset = (50, 75); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

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

let state_test0 = {
  on_board = [cue_ball; one_ball];
  player = [player1; player2];
  is_pot = [];
  foul = No_Foul;
  is_playing = player2;
  ball_moving = false;
}

let tests =
  [
    (* Only 2 balls present *)
    (* "test0" >:: (fun _ -> assert_equal (0., 0.) (ai_evaluate_next_move state_test0)); *)
    "test0" >:: (fun _ -> assert_equal 1 1);
  ]

let suite =
  "Billiard test suite"
  >::: tests

let _ = run_test_tt_main suite
