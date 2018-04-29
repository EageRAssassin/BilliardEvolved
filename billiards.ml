open Types

let cue_ball = {
  suit = 0;
  name = "Cue Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (780.,278.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 75.); (*chooses which on the image provided to take from*)
  };
  image = "billiards.png";
  mass = 10.;
}

let one_ball = {
  suit = 1;
  name = "One Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (302.,278.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (50., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let two_ball = {
  suit = 2;
  name = "Two Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (218.,302.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (100., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let three_ball = {
  suit = 3;
  name = "Three Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (281.,266.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (150., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let four_ball = {
  suit = 4;
  name = "Four Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (239.,266.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (200., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let five_ball = {
  suit = 5;
  name = "Five Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (218.,254.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (250., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let six_ball = {
  suit = 6;
  name = "Six Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (260.,302.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (300., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let seven_ball = {
  suit = 7;
  name = "Seven Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (218.,326.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (350., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let eight_ball = {
  suit = 8;
  name = "Eight Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (260.,278.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (400., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let nine_ball = {
  suit = 9;
  name = "Nine Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (239.,242.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.);(*size of billiard ball on THE IMAGE*)
    offset = (450., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let ten_ball = {
  suit = 10;
  name = "Ten Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (218.,278.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (500., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let eleven_ball = {
  suit = 11;
  name = "Eleven Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (281.,290.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (550., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let twelve_ball = {
  suit = 12;
  name = "Twelve Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (218.,230.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (600., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let thirteen_ball = {
  suit = 13;
  name = "Thirteen Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (239.,314.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (650., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let fourteen_ball = {
  suit = 14;
  name = "Fourteen Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (260.,254.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (700., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let fifteen_ball = {
  suit = 15;
  name = "Fifteen Ball" ;
  size = (25.,25.);
  velocity = (0.,0.);
  position = (239.,290.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25.,25.); (*size of billiard ball on THE IMAGE*)
    offset = (750., 75.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}
