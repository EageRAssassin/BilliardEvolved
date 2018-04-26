(*consider putting billiards, foul, state TYPE DEFINITION
  here. State.ml should contain functions and not type
  definitions *)

type id = int

type foul = Illegal_eight|Cue_eight|Cue_pot|Hit_wrong|No_hit_side|No_hit_ball

type player = {
  (* legal_pot: billiard list; *)
  is_playing : bool;
  score : int;
  cue : int;
  money: int;
}

type image_dim =
  {img: string;
   size: int * int;
   offset: int* int;
  }

type score = int

type billiard =
  {
    suit: int;
    name: string;
    size: (int * int);
    velocity: float*float;
    position: float*float;
    score: int;
    legal_player: player option; (* the player who can first_hit it without penalty*)
    legal_pot: player option; (* the player who can pot it without penalty*)
    dim: image_dim;
    image: string;
  }

type state = {
  on_board : billiard list;
  player : player list;
  is_pot : billiard list;
  foul : foul;
  is_playing : player;
  ball_moving : bool;
}
