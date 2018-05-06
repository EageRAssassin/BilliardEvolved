open Types

let init_pool_cue : pool_cue = {
  cue_name = "default_cue" ;
  cue_dim = {
    img = "pool_cue.png";
    size = (520., 12.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 0.); (*chooses which on the image provided to take from*)
  };
  bearing = 0.;
  cue_position = (820., 289.);
}
