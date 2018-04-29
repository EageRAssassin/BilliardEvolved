open Types

(*The type state contains the following fields:
  [on_board] : a billiard list of billiard balls that is on the board
  [player] : the player list of players in the game
  [is_pot] : the billiard list of billard that has been pot in the pocket
             (i.e. not on the playing table)
  [foul] : type of foul that the current player triggered
  [is_playing] : the player that is playing the game in the state
  [ball_moving] : true if one of the ball is moving, false if all not moving
                  used as a cue to change state (see below)
*)
type state = {
  on_board : billiard list;
  player : player list;
  is_pot : billiard list;
  foul : foul;
  is_playing : player;
  ball_moving : bool;
}

(* type billiards: see billiard.mli *)

(* type player: see player.mli *)

(* foul: see foul .mli *)

(* [change_state st] will change the attributes of fields in [st] and
 * update those fields to make the next change_state
   requires:
   [st] is a game state
 *)
val change_state : state -> state



(* [next_turn st] will trigger the next turn where the user is given
   control after all balls cease movement
   requires:
   [st] is current game state
 *
 *)
val next_turn : state -> state
