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


(* [kinetic_transfer (dx,dy) st] takes a velocity tuple (dx,dy) which is
   the change in (x,y) coordinate that will occur this state [st]

   the function reads all objects in motion (|dx,dy| > 0) in the current
   state [st]. two things can happen:
    1. objects slow down on their own: we will programme in a friction
       speed decay based on its current speed (faster speed = faster decay)
    2. velocity transfer: if two objects collide depending on angle and
       velocity of obj a, obj b will gain a (x,y) and obj a will lose (x,y)
    3. works for cue striking billiard (user input), billiard hit billiard,
       billiard bounce off walls

   requires:
   [(int*int)] is a tuple of int
   [st] is current game state
 *)
val kinetic_transfer : ( int * int ) -> state -> state


(* [next_turn st] will trigger the next turn where the user is given
   control after all balls cease movement
   requires:
   [st] is current game state
 *
 *)
val next_turn : state -> state

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
val ai_evaluate_next_move : state -> ( int * int )
