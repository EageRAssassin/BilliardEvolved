open Types

(* [ai_evaluate_next_move st] will use our AI to analyze the current
 * state to produce the optimal velocity (direction + speed) of the
   cue and which billiard to hit towards which pocket to play against
 * the player
   requires:
   [st] is a state
*)
let ai_evaluate_next_move st =
  (1,2)
