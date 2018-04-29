open Types

let cue_ball = {
  suit = 0;
  name = "Cue Ball" ;
  size = (25,25);
  velocity = (0,0);
  position = (500,500); (*see arrangement.png for init. for now all are
                          the same place *)
  score = -100; (*should never be potted*)
  legal_player = None;
  legal_pot = None;
  dim = {
    img = "billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "billiards.png";
}

let one_ball = {
  suit = 1;
  name = "One Ball" ;
  size = (25,25);
  velocity = (0,0);
  position = (500,500); (*see arrangement.png for init. for now all are
                          the same place *)
  score = 100;
  legal_player = None; (* whoever pots a solid first *)
  legal_pot = None;
  dim = {
    img = "billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (50., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let two_ball = {
  suit = 2;
  name = "Two Ball" ;
  size = (25,25);
  velocity = (0,0);
  position = (500,500); (*see arrangement.png for init. for now all are
                          the same place *)
  score = 100;
  legal_player = None; (* whoever pots a solid first *)
  legal_pot = None;
  dim = {
    img = "billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (100., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let three_ball = {
  suit = 3;
  name = "Three Ball" ;
  size = (25,25);
  velocity = (0,0);
  position = (500,500); (*see arrangement.png for init. for now all are
                          the same place *)
  score = 100;
  legal_player = None; (* whoever pots a solid first *)
  legal_pot = None;
  dim = {
    img = "billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (150., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

    (* etc. for other balls too *)
