open Types


let cue_ball = {
  suit = 0;
  name = "Cue Ball" ;
  size = (30.,30.);
velocity = (0.,0.);
  position = (780.,290.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = -100; (*should never be potted*)
  (* legal_player = None;
     legal_pot = None; *)
  (*it seems like these do not matter *)
  dim = {
    img = "";
    size = (0., 0.); (*size of billiard ball on THE IMAGE*)
    offset = (0., 0.); (*chooses which on the image provided to take from*)
  };
  (*also not needed*)
  image = "";
  mass = 10.;
}

let one_ball = {
  suit = 1;
  name = "One Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (312.,290.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
   dim = {
     img = "";
     size = (0., 0.); (*size of billiard ball on THE IMAGE*)
     offset = (0., 0.); (*chooses which on the image provided to take from*)
   };
  image = "billiards.png";
  mass = 10.;
}

let two_ball = {
  suit = 2;
  name = "Two Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (208.,320.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (100., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let three_ball = {
  suit = 3;
  name = "Three Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (286.,275.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (150., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let four_ball = {
  suit = 4;
  name = "Four Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (234.,275.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (25., 25.); (*size of billiard ball on THE IMAGE*)
    offset = (200., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let five_ball = {
  suit = 5;
  name = "Five Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (208.,260.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (250., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let six_ball = {
  suit = 6;
  name = "Six Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (260.,320.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (300., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let seven_ball = {
  suit = 7;
  name = "Seven Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (208.,350.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (350., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let eight_ball = {
  suit = 8;
  name = "Eight Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (260.,290.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (400., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let nine_ball = {
  suit = 9;
  name = "Nine Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (234.,245.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.);(*size of billiard ball on THE IMAGE*)
    offset = (450., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let ten_ball = {
  suit = 10;
  name = "Ten Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (208.,290.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (500., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let eleven_ball = {
  suit = 11;
  name = "Eleven Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (286.,305.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (550., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let twelve_ball = {
  suit = 12;
  name = "Twelve Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (208.,230.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (600., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let thirteen_ball = {
  suit = 13;
  name = "Thirteen Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (234.,335.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (650., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let fourteen_ball = {
  suit = 14;
  name = "Fourteen Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (260.,260.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (700., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}

let fifteen_ball = {
  suit = 15;
  name = "Fifteen Ball" ;
  size = (30.,30.);
velocity = (800.,800.);
  position = (234.,305.); (*see arrangement.png for init. for now all are
                            the same place *)
  score = 100;
  (* legal_player = None; (* whoever pots a solid first *)
     legal_pot = None; *)
  dim = {
    img = "billiards.png";
    size = (30.,30.); (*size of billiard ball on THE IMAGE*)
    offset = (750., 0.); (*each billiard separated by exactly 25 pixels *)
  };
  image = "billiards.png";
  mass = 10.;
}
