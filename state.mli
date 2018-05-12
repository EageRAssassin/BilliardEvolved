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

 (* [next_round st] will trigger the next round where the user is given
    control after all balls cease movement
    requires:
    [st] is current game state
  *
  *)
val next_round : state -> unit
