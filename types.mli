(*consider putting billiards, foul, state TYPE DEFINITION
  here. State.ml should contain functions and not type
  definitions *)

type id = int

type foul = Illegal_eight|Cue_eight|Cue_pot|Hit_wrong|No_hit_side|No_hit_ball|No_foul

type player =
  {
    (* legal_pot: billiard list; *)
    name: string;
    is_playing : bool;
    score : int;
    cue : int;
    money: int;
  }

type image_dim =
  {
    img: string;
    size: float * float;
    offset: float * float;
  }

type score = int

type billiard =
  {
    suit: int;
    name: string;
    size: float * float;
    mutable velocity: float * float;
    mutable position: float * float;
    score: int;
    (* legal_player: player option; (* the player who can first_hit it without penalty*)
       legal_pot: player option; (* the player who can pot it without penalty*) *)
    mutable dim: image_dim;
    image: string;
    mass: float;
  }

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
    mutable current_table_id: string;
    is_playing : player;
    foul : foul;
    hit_force : float * float;
    player_aiming : bool;
  }

type command =
  {
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
