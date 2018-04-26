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

let four_ball = {
  suit = 4;
  name = "Four Ball" ;
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
    offset = (200., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let five_ball = {
  suit = 5;
  name = "Five Ball" ;
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
    offset = (250., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let six_ball = {
  suit = 6;
  name = "Six Ball" ;
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
    offset = (300., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let seven_ball = {
  suit = 7;
  name = "Seven Ball" ;
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
    offset = (350., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let eight_ball = {
  suit = 8;
  name = "Eight Ball" ;
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
    offset = (400., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let nine_ball = {
  suit = 9;
  name = "Nine Ball" ;
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
    offset = (450., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let ten_ball = {
  suit = 10;
  name = "Ten Ball" ;
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
    offset = (500., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let eleven_ball = {
  suit = 11;
  name = "Eleven Ball" ;
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
    offset = (550., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let twelve_ball = {
  suit = 12;
  name = "Twelve Ball" ;
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
    offset = (600., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let thirteen_ball = {
  suit = 13;
  name = "Thirteen Ball" ;
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
    offset = (650., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let fourteen_ball = {
  suit = 14;
  name = "Fourteen Ball" ;
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
    offset = (700., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}

let fifteen_ball = {
  suit = 15;
  name = "Fifteen Ball" ;
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
    offset = (750., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
}



    (* etc. for other balls too *)
