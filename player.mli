open billiard
(*the type player has the following fields:
  [legal_pot]:
  [is_playing]:
  [score]:
  [cue]:
  [money]:
*)
type player = {
  legal_pot: billiard list;
  is_playing : bool;
  score : int;
  cue : int;
  money: int;
}
