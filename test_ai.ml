open OUnit2

(* let state_test =  *)

let tests =
  [
    "blind_attack" >::
    (fun _ -> assert_equal 1 1);
  ]

let suite =
  "Billiard test suite"
  >::: tests

let _ = run_test_tt_main suite
