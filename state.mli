open billiard
open player
open foul
(*the type state contains the following fields:
  [on_board] :
  [player] :
  [is_plot] :
  [foul] :
  [is_playing] :
  [ball_moving] :
*)
type state = {
  on_board : billiard list;
  player : player list;
  is_plot : billard list;
  foul : foul;
  is_playing : player;
  ball_moving : bool;
}
