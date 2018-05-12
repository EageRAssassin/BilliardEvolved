
(*consider putting billiards, foul, state TYPE DEFINITION
  here. State.ml should contain functions and not type
  definitions *)

type id = int

type image_dim =
  {
    img: string;
    size: float * float;
    offset: float * float;
  }

type billiard =
  {
    suit: int;
    name: string;
    size: (float * float);
    mutable velocity: float*float;
    mutable position: float*float;
    score: int;
    (* legal_player: player option; (* the player who can
       first_hit it without penalty*)
       legal_pot: player option; (* the player who can pot
       it without penalty*) *)
    mutable dim: image_dim;
    image: string;
    mass: float;
  }

type foul =
    Illegal_eight|Cue_eight|Cue_pot|Hit_wrong|No_hit_side|No_hit_ball|No_foul

type player =
  {
    mutable legal_pot: billiard list;
    name: string;
    mutable is_playing : bool;
    score : int;
    cue : int;
    money: int;
  }


type score = int


(* type pool_cue = {
  cue_name: string;
  mutable cue_dim: image_dim;
  mutable bearing: float; (*pointing left is 0*)
  mutable cue_position: float*float; (*position of tip is this + 2*)
} *)

type table =
  {
    table_id: string;
    width: float;
    height: float;
  }

type state =
  {
    counter: int;
    mutable on_board : billiard list;
    cue_bearing: float;
    gap: float;
    is_collide: bool;
    cue_pos: float*float;
    player : player list;
    is_pot : billiard list;
    ball_moving : bool;
    prev_ball_moving : bool;
    mutable current_table_id: string;
    mutable is_playing : player;
    mutable foul : foul;
    hit_force : float * float;
    mutable player_aiming : bool;
    mutable win: int; (*0 no one win, 1 play win, 2 AI win*)
    mutable round: int;
  }

type command = {
  mutable w : bool;
  mutable a : bool;
  mutable s : bool;
  mutable d : bool;
  mutable j : bool;
  mutable q : bool;
  mutable e : bool;
  mutable two : bool;
  mutable x : bool;
}


(* type state = {
   on_board : billiard list;
   player : player list;
   is_pot : billiard list;
   foul : foul;
   is_playing : player;
   ball_moving : bool;
   } *)
