open Types

let player_command = {
  w = false;
  a = false;
  s = false;
  d = false;
  j = false;
  q = false;
  e = false;
  cue = 0;
  x = false;
  cue_coord = (0., 0.);
  cue_bearing = 0.;
  cue_gap = 0.;
  cue_release = false;
  egg_counter = 0;
}
