(*the billiard contains the following fields:
  [position] : tuple (x,y) is the position of the billiard
  [suit] : is the colour and number of the billiard according
  to convention (e.g. 8 is solid black 8 ball)
  [velocity] : tuple (dx,dy) is the change in coordinate position
  between this state and the next for any object with position
  the |x,y| or magnitude is its speed and the ratio is its direction
*)
type billiard = {
  mutable position: float*float;
  suit : int ;
  mutable velocity: float*float;
  mass : float ;
}
