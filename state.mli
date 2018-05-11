open Types

(* do` st takes in all commands (both player and AI) and updates
 * do takes in state, recurively calls spriteAction on each sprite
 * returns state *
 * the state and all sprites accordingly
 * requires: st is a state
 * returns: the state after each frame, with everything updated as per
 * the spec in the above functions *)


 (* [change_state st] will change the attributes of fields in [st] and
  * update those fields to make the next change_state
    requires:
    [st] is a game state
  *)
val change_state : state -> state

(* [change_force st] will change the attributes of hit_force in [st] according
   to the attribute [direction]
   direction: 1 -> up; 2 -> left; 3 -> down; 4 -> right;
   requires:
   [st] is a game state
   [direciton] is a integer value from 1 and 4
*)
val change_force : state -> int -> state

 (* [next_round st] will trigger the next round where the user is given
    control after all balls cease movement
    requires:
    [st] is current game state
  *
  *)
val next_round : state -> state
