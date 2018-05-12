open Types
open Billiards

let player1 = {

  name = "player_1";
  is_playing = true;
  score = 0;
  cue = 0;
  money = 0;
  legal_pot = cue_ball::one_ball::two_ball::three_ball::four_ball::five_ball::
              six_ball::seven_ball::eight_ball::[];
}

let player2 = {

  name = "player_2";
  is_playing = false;
  score = 0;
  cue = 0;
  money = 0;
  legal_pot = nine_ball::ten_ball::eleven_ball::twelve_ball::thirteen_ball::fourteen_ball::
              fifteen_ball::eight_ball::[];
}
