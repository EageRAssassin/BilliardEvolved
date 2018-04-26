open Types

(* [ai_evaluate_next_move st] will use our AI to analyze the current
 * state to produce the optimal velocity (direction + speed) of the
   cue and which billiard to hit towards which pocket to play against
 * the player
   requires:
   [st] is a state

   note: most likely this would be implemented by analysing the following:
   1. calculate the velocity needed to get the legal ball into a pocket
   2. direct angles are prioritised (i.e. cue ball, ball and pocket lines up)
   3. line of travel is not obstructed (no ball between ball and pocket.

*)
val ai_evaluate_next_move : state -> ( float * float )