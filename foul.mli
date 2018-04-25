(*The variant foul contains the following constructors, meaning what rules is illegal
  Illegal_eight: Pot ball 8 before 8 is legal (loses game)
  Cue_eight: Pot ball 8 legally BUT cue ball also pocketed (loses game)
  Cue_pot: cue ball is pocketed, switch player, place white default
  Hit_wrong: cue ball first contact with illegal billiard
  No_hit_side: a billiard is hit but no pocket made and side is contacted
  No_hit_ball: the cue ball failed to touch any other billiard
 *)
type foul = Illegal_eight|Cue_eight|Cue_pot|Hit_wrong|No_hit_side|No_hit_ball
