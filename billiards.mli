(*the billiard contains the following fields:
  [position] : tuple (x,y) is the position of the billiard
  [suit] : is the colour and number of the billiard according
  to convention (e.g. 8 is solid black 8 ball)
  [velocity] : tuple (dx,dy) is the change in coordinate position
  between this state and the next for any object with position
  the |x,y| or magnitude is its speed and the ratio is its direction
*)

open Types


val cue_ball: billiard
val one_ball: billiard
val two_ball: billiard
val three_ball: billiard
val four_ball: billiard
val five_ball: billiard
val six_ball: billiard
val seven_ball: billiard
val eight_ball: billiard
val nine_ball: billiard
val ten_ball: billiard
val eleven_ball: billiard
val twelve_ball: billiard
val thirteen_ball: billiard
val fourteen_ball: billiard
val fifteen_ball: billiard

(*media/billiards.png.ml billiard.mli *)
