open billiard
open player
open foul
(*the type state contains the following fields:
  [on_board] : the list of billiard that is on the board
  [player] : the list of players in the game
  [is_pot] : the list of billard that has been pot in the pocket
  [foul] :
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
