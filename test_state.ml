open OUnit2
open Types
open State


let tests =
  [
    "test_0" >:: (fun _ -> assert_equal true (true));
    "test_0" >:: (fun _ -> assert_equal true (true));
    "test_0" >:: (fun _ -> assert_equal true (true));
    
    (* "test_billiard_between0" >:: (fun _ -> assert_equal true ( (0. , 0.) (100., 100.) billiard_between_list1)); *)
    (* change_state state_cue_moving *)
  ]

let suite =
  "Billiard state test suite"
  >::: tests

let _ = run_test_tt_main suite
