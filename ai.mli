open Types

(* [ai_evaluate_next_move st] uses our AI to analyze the current
 * state to produce the optimal velocity (x velocit, y velocity) of the
   cue and which billiard to hit towards which pocket to play against
   the player
   requires:
   [st] is a state
*)
val ai_evaluate_next_move : state -> (float * float)

(* helper functions, listed for testing purposes *)
(* [search1_possible st] will evaluate the whether the strategy in search1
   is possible, and return the suit of the ball if the strategy is possible.
   It returns -1 if the strategy is impossible
   returns: the number of billaird in the legal list if strategy is possible,
            -1 if impossible
   requires: [st] is a valid state *)
val search1_possible : state -> int

(* [search1_calculation white_position ball_position billiards] will return the
   x and y vector that AI needs to hit [ball_position] from [white_position]
   directly if there is any billaird in [billiards] between the ball and the
   pocket, AI will increase its strength. *)
val search1_calculation : (float*float) ->  (float*float) -> billiard list
  -> (float*float)

(* [billiard_between position1 position2] will return true if there are
   billiards between two balls of position1 and position2
   requires: billiards is a list with valid billiards *)
val billiard_between : (float*float) -> (float*float) -> billiard list -> bool

(* [nearst_billiard cue_position billiards] will return the vector needed to hit
   from the cue_position to the closest billiard
   required: [billiards] is not an empty list *)
val closest_billiard : (float*float) -> billiard list -> (float*float)
  -> (float*float)
