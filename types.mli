(*consider putting billiards, foul, state TYPE DEFINITION
  here. State.ml should contain functions and not type
  definitions *)

type id = int

(*The variant foul contains the following constructors, meaning what rules is illegal
  Illegal_eight: Pot ball 8 before 8 is legal (loses game)
  Cue_eight: Pot ball 8 legally BUT cue ball also pocketed (loses game)
  Cue_pot: cue ball is pocketed, switch player, place white default
  Hit_wrong: cue ball first contact with illegal billiard
  No_hit_side: a billiard is hit but no pocket made and side is contacted
  No_hit_ball: the cue ball failed to touch any other billiard
*)
type foul = Illegal_eight|Cue_eight|Cue_pot|Hit_wrong|No_hit_side|No_hit_ball

(*the type player has the following fields:
  [legal_pot]: a list of the billiard that can be legally pocketed by the
  player (e.g. stripes, solids, black )
  [is_playing]: whether this player is playing at this turn
  [score]: the player's score
  [cue]: the amount of power on the tip of the cue for this player
  [money]: the player's money
*)
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

(*the billiard contains the following fields:
  [position] : tuple (x,y) is the position of the billiard
  [suit] : is the colour and number of the billiard according
  to convention (e.g. 8 is solid black 8 ball)
  [velocity] : tuple (dx,dy) is the change in coordinate position
  between this state and the next for any object with position
  the |x,y| or magnitude is its speed and the ratio is its direction
*)
type billiard =
  {
    suit: int;
    name: string;
    size: (int * int);
    mutable velocity: float*float;
    mutable position: float*float;
    score: int;
    legal_player: player option; (* the player who can first_hit it without penalty*)
    legal_pot: player option; (* the player who can pot it without penalty*)
    dim: image_dim;
    image: string;
    mass: float;
  }

type state = {
  on_board : billiard list;
  player : player list;
  is_pot : billiard list;
  foul : foul;
  is_playing : player;
  ball_moving : bool;
}
