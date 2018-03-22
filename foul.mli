(*The variant foul contains the following constructors, meaning what rules is illegal
  Illegal_eight: Pot ball 8 before clear all
  Cue_eight: Pot ball 8 with cue
  Cue_pot: switch player, place white default
  Hit_wrom: first contact with illegal
  No_hit_side: no touch side
  No_hit_ball: no touch any ball
 *)
type foul = Illegal_eight|Cue_eight|Cue_pot|Hit_wrom|No_hit_side|No_hit_ball
