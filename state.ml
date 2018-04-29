open billiard
open player
open foul

(*The type state contains the following fields:
  [on_board] : a billiard list of billiard balls that is on the board
  [player] : the player list of players in the game
  [is_pot] : the billiard list of billard that has been pot in the pocket
             (i.e. not on the playing table)
  [foul] : type of foul that the current player triggered
  [is_playing] : the player that is playing the game in the state
  [ball_moving] : true if one of the ball is moving, false if all not moving
                  used as a cue to change state (see below)
*)
type state = {
  on_board : billiard list;
  player : player list;
  is_pot : billard list;
  foul : foul;
  is_playing : player;
  ball_moving : bool;
}

(* type billiards: see billiard.mli *)

(* type player: see player.mli *)

(* foul: see foul .mli *)

(* HELPER FUNCTION GOES BELOW *)

let radius = 1

(* [collide b1 b2]Collides two balls and changes their velocities accordingly
   requires : b1 and b2 are valid billiard records *)
let collide (b1 : billiard) (b2 : billiard) =
(* distances to bewteen centers and collision *)
  let x1 = fst (b1.position) + radius ref in
  let x2 = fst (b2.position) + radius ref in
  let y1 = snd (b1.position) + radius ref in
  let y2 = snd (b2.position) + radius ref in
  (* real distances (collision overlap) *)
  let dxR = x2 - x1 in
  let dyR = y2 - y1 in
  (* gets the ACTUAL distance between the two balls *)
  let distance = Math.sqrt(DxR * DxR + DyR * DyR) in

  (* RadSum adds radii, this gives the ideal distance *)
  (* imaginary distances (no overlap) *)
  let dx = 2 *. dxR /. distance in
  let dy = 2 *. dyR /. distance in

  (*   so that things dont look screwy when we have a fast tiny ball collide with
a slow big one we want it to be the small ball that will have its position adjusted *)


  if b1.mass < b2.mass then
    x1 := ( !x1 - (dx - dxR));
    y1 := ( !x1 - (dy - dyR));
    b1.position <- (!x1 - radius, !y1 - radius);
    else
    x2 := (!x2 + (dx - dxR));
    y2 := (!y2 + (dy - dyR));
    fst b2.position <- !x2 - radius;
    snd b2.position <- !y2 - radius;

(* Find the x and y distances from the centers of each ball to the collision point *)

(* Distances to the collision point *)
    let dx1 = (1/2 ) * (!x2 - !x1) in
    let dx2 = (1/2 ) * (!x2 - !x1) in

    let dy1 = (1/2 ) * (!y2 - !y1) in
    let dy2 = (1/2 ) * (!y2 - !y1) in

  (* calculate the components of velocity of each ball headed towards the collision point and perpendicular to it *)
(* normal and perpendicular velocities to collision *)
   let vs1 = straight_Velocity(fst b1.velocity, snd b1.velocity, dx1, dy1, radius);
   let vp1 = perpendicular_Velocity(fst b1.velocity, snd b1.velocity, dx1, dy1, radius);

   let vs2 = straight_Velocity(fst b2.velocity, snd b2.velocity, dx2, dy2, radius) in
   let vp2 = perpendicular_Velocity(fst b2.velocity, snd b2.velocity, dx2, dy2, radius) in

  (* use the formulas in the method to find new straight velocities for each ball *)
  (* for storing new straigth velocites during calculations *)
   let newVs1 = collision_Velocity(vs1, vs2, b1.mass, b2.mass) in
   let newVs2 = collision_Velocity(vs2, vs1, b2.mass, b1.mass) in

  (* now we get new X and Y velocities for each, using the new straight velocity and the unaffected perpendicular velocity component
  *)
   let vxx_new = x_Velocity(newVs1, vp1, dx1, dy1, radius) in
   let vxy_new = y_Velocity(newVs1, vp1, dx1, dy1, radius) in
   b1.velocity <- (vxx_new,vxy_new);

   let vyx_new = x_Velocity(newVs2, vp2, dx2, dy2, radius) in
   let vyy_new = y_Velocity(newVs2, vp2, dx2, dy2, radius) in
   b2.velocity <- (vxx_new,vxy_new)

(* [straight_Velocity vx vy dx dy r] returns velocity directed towards collision *)
let straight_Velocity vx vy dx dy r = vx *. dx /. r +. vy *. dy /. r
(* [perpendicular_Velocity vx vy dx dy r] returns velocity perpendicular to collision *)
let perpendicular_Velocity  vx vy dx dy r =  vy *. dx /. r -. vx *. dy /. r
(* [x_Velocity vs vp dx dy r] returns x velocity from S and P *)
let x_Velocity vs vp dx dy r =  vs *. dx /. r -. vp *. dy /. r
(* [y_Velocity vs vp dx dy r] returns y velocity from S and P   *)
let y_Velocity vs vp dx dy r =  vs *. dy /. r +. vp *. dx /. r
 (* [collision_Velocity v1 v2 m1 m2]returns velocity of a ball after collision *)
let collision_Velocity v1 v2 m1 m2 =
  v1 *. (m1-.m2) /. (m1+.m2) +. v2 *. (2 *. m2) /. (m1 +. m2)

let check_wall_touching ball =
  let radius = 1 in
  let x_left = fst ball.position in
  let y_top = snd ball.position in
  (* Py measures the top left coord of ball, so we add two radii *)
  let y_bottom = snd ball.position + 2*.radius in
  (* to get the bottom and right y and x coords. *)
  let x_right = fst ball.position + 2*.radius in

    if (x_left < )
    then
      ball.position <- (... ,snd ball.position)
      ball.velocity <- ((-fst ball.velocity), snd ball.velocity)
    if  (y_top < )
    then
     ball.position <- ( fst ball.position, )
     ball.velocity <- ((-fst ball.velocity), snd ball.velocity)
    if (x_right > )
    then
      ball.position <- (  - 2 , snd ball.position)
      ball.velocity <- ((-fst ball.velocity), snd ball.velocity)
    if (y_bottom > )
    then



(* [change_state st] will change the attributes of fields in [st] and
 * update those fields to make the next change_state
   requires:
   [st] is a game state
 *)
let change_state st = st


(* [kinetic_transfer (dx,dy) st] takes a velocity tuple (dx,dy) which is
   the change in (x,y) coordinate that will occur this state [st]

   the function reads all objects in motion (|dx,dy| > 0) in the current
   state [st]. two things can happen:
    1. objects slow down on their own: we will programme in a friction
       speed decay based on its current speed (faster speed = faster decay)
    2. velocity transfer: if two objects collide depending on angle and
       velocity of obj a, obj b will gain a (x,y) and obj a will lose (x,y)
    3. works for cue striking billiard (user input), billiard hit billiard,
       billiard bounce off walls

   requires:
   [(int*int)] is a tuple of int
   [st] is current game state
 *)
let kinetic_transfer x y st = st


(* [next_turn st] will trigger the next turn where the user is given
   control after all balls cease movement
   requires:
   [st] is current game state
 *
 *)
let next_turn st = st

(* [ai_evaluate_next_move st] will use our AI to analyze the current
 * state to produce the optimal velocity (direction + speed) of the
   cue and which billiard to hit towards which pocket to play against
 * the player
   requires:
   [st] is a state

   note: most likely this would be implemented by analysing the following:
   1. calculate the velocity needed to get the legal ball into a pocket
   2. direct angles are prioritised (i.e. cue ball, ball and pocket lines up)
   3. line of travel is not obstructed (no ball between ball and pocket.

  *)
let ai_evaluate_next_move st = (1,2)
