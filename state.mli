open billiard
open player
open foul

(*The type state contains the following fields:
  [on_board] : the list of billiard that is on the board
  [player] : the list of players in the game
  [is_pot] : the list of billard that has been pot in the pocket
  [foul] : type of foul that the current user triggered
  [is_playing] : the player that is playing the game in the state
  [ball_moving] : true if one of the ball is moving, false if all not moving 
*)
type state = {
  on_board : billiard list;
  player : player list;
  is_pot : billard list;
  foul : foul;
  is_playing : player;
  ball_moving : bool;
}

(* [change_state st] will change the inner attributes of [st] into 
 * the next state
 *)
val change_state : state -> state

(* [kinetic_transfer direction force] will  
 *
 *)
val kinetic_transfer : ( int * int ) -> state -> state

(* [next_turn st] will  
 *
 *)
val next_turn : state -> state 

(* [ai_evaluate_next_move st] will use our AI to analyze the current 
 * state to produce the optimal direction and speed to play against 
 * the player 
 *)
val ai_evaluate_next_move : state -> ( int * int )