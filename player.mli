open Types
(*the type player has the following fields:
  [legal_pot]: a list of the billiard that can be legally pocketed by the
  player (e.g. stripes, solids, black )
  [is_playing]: whether this player is playing at this turn
  [score]: the player's score
  [cue]: the amount of power on the tip of the cue for this player
  [money]: the player's money
*)

val player1 : player
val player2 : player
