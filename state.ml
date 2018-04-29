open Types

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
  is_pot : billiard list;
  foul : foul;
  is_playing : player;
  ball_moving : bool;
}

(* type billiards: see billiard.mli *)

(* type player: see player.mli *)

(* foul: see foul .mli *)

(* HELPER FUNCTION GOES BELOW *)

let radius = 20.

(* [collide b1 b2]Collides two balls and changes their velocities accordingly
   requires : b1 and b2 are valid billiard records *)
let collide (b1 : billiard) (b2 : billiard) =
(* distances to bewteen centers and collision *)
  let x1 = ref (fst (b1.position) +. radius) in
  let x2 = ref (fst (b2.position) +. radius) in
  let y1 = ref (snd (b1.position) +. radius) in
  let y2 = ref (snd (b2.position) +. radius) in
  (* real distances (collision overlap) *)
  let dxR = (!x2 -. !x1 )in
  let dyR = (!y2 -. !y1) in
  (* gets the ACTUAL distance between the two balls *)
  let distance = sqrt(dxR *. dxR +. dyR *. dyR) in

  (* RadSum adds radii, this gives the ideal distance *)
  (* imaginary distances (no overlap) *)
  let dx = 2. *. dxR /. distance in
  let dy = 2. *. dyR /. distance in

  (*   so that things dont look screwy when we have a fast tiny ball collide with
a slow big one we want it to be the small ball that will have its position adjusted *)


    x1 := ( !x1 -. (dx -. dxR));
    y1 := ( !x1 -. (dy -. dyR));
    b1.position <- (!x1 -. radius, !y1 -. radius);


  (* Find the x and y distances from the centers of each ball to the collision point *)

  (* Distances to the collision point *)
    let dx1 = (!x2 -. !x1) /. 2. in
    let dx2 = (!x2 -. !x1) /. 2. in
    let dy1 = (!y2 -. !y1) /. 2. in
    let dy2 = (!y2 -. !y1) /. 2. in

  (* [straight_Velocity vx vy dx dy r] returns velocity directed towards collision *)
  let straight_Velocity vx vy dx dy r = vx *. dx /. r +. vy *. dy /. r in
  (* [perpendicular_Velocity vx vy dx dy r] returns velocity perpendicular to collision *)
  let perpendicular_Velocity  vx vy dx dy r =  vy *. dx /. r -. vx *. dy /. r in
  (* [x_Velocity vs vp dx dy r] returns x velocity from S and P *)
  let x_Velocity vs vp dx dy r =  vs *. dx /. r -. vp *. dy /. r in
  (* [y_Velocity vs vp dx dy r] returns y velocity from S and P   *)
  let y_Velocity vs vp dx dy r =  vs *. dy /. r +. vp *. dx /. r in
  (* [collision_Velocity v1 v2 m1 m2]returns velocity of a ball after collision *)
  let collision_Velocity v1 v2 m1 m2 =
    v1 *. (m1-.m2) /. (m1+.m2) +. v2 *. (2. *. m2) /. (m1 +. m2) in


  (* calculate the components of velocity of each ball headed towards the collision point and perpendicular to it *)
(* normal and perpendicular velocities to collision *)
   let vs1 = straight_Velocity (fst b1.velocity) (snd b1.velocity) dx1 dy1 radius in
    let vp1 = perpendicular_Velocity (fst b1.velocity) (snd b1.velocity) dx1 dy1 radius in

   let vs2 = straight_Velocity (fst b2.velocity) (snd b2.velocity) dx2 dy2 radius in
    let vp2 = perpendicular_Velocity (fst b2.velocity) (snd b2.velocity) dx2 dy2 radius in

  (* use the formulas in the method to find new straight velocities for each ball *)
  (* for storing new straigth velocites during calculations *)
   let newVs1 = collision_Velocity vs1  vs2  b1.mass  b2.mass in
   let newVs2 = collision_Velocity vs2 vs1 b2.mass b1.mass in

  (* now we get new X and Y velocities for each, using the new straight velocity and the unaffected perpendicular velocity component
  *)
   let vxx_new = x_Velocity newVs1 vp1 dx1 dy1 radius in
   let vxy_new = y_Velocity newVs1 vp1 dx1 dy1 radius in
   b1.velocity <- (vxx_new, vxy_new);

   let vyx_new = x_Velocity newVs2 vp2 dx2 dy2 radius in
   let vyy_new = y_Velocity newVs2 vp2 dx2 dy2 radius  in
   b2.velocity <- (vyx_new, vyy_new)


let check_wall_touching ball =
  let radius = 20. in
  let x_left = fst ball.position in
  let y_top = snd ball.position in
  (* Py measures the top left coord of ball, so we add two radii *)
  let y_bottom = snd ball.position +. 2. *. radius in
  (* to get the bottom and right y and x coords. *)
  let x_right = fst ball.position +. 2. *. radius in

    if (x_left < 0. )
    then
      begin
        ball.position <- (0., snd ball.position);
      ball.velocity <- (-.fst ball.velocity, snd ball.velocity)
      end;
    if (y_top < 0.)
    then
      begin
      ball.position <- (fst ball.position, 0.);
      ball.velocity <- (fst ball.velocity, -.snd ball.velocity)
      end;
    if (x_right > 1240.)
    then
      begin
      ball.position <- (1240. -. 2., snd ball.position);
      ball.velocity <- (-.fst ball.velocity, snd ball.velocity)
      end;
    if (y_bottom > 620.)
    then
      begin
      ball.position <- (fst ball.position, 620. -. 2.);
      ball.velocity <- (fst ball.velocity, -.snd ball.velocity)
      end

(* [move_ball_position time ball] moves the [ball] for [time] second, change the position
   requires: [ball] is a valid billiard,
             [time] is a valid int*)
let move_ball_position time ball=
  let tempx = (fst ball.position) +. (fst ball.velocity *. time) in
  let tempy = (snd ball.position) +. (snd ball.velocity *. time) in
  ball.position <- (tempx,tempy)

(* [move_ball_velocity time ball] moves the [ball] for [time] second, change the velocity
   requires: [ball] is a valid billiard*)
let move_ball_velocity ball =
  let tempx = ref ( (fst ball.velocity) *. 0.9 )  in
  let tempy = ref ( (snd ball.velocity) *. 0.9 )  in
  if !tempx < 1. then tempx := 0.;
  if !tempy < 1. then tempy := 0.;
  ball.velocity <- (!tempx, !tempy);
  ball

(* [check_ball_moving ball] will give check if the [ball] is moving,
   return: true if [ball] is moving *)
let rec check_ball_moving (ball : billiard) : bool =
  fst ball.velocity <> 0. || snd ball.velocity <> 0.

(* [check_ball_moving billiards] will check if there is any billard ball moving
   on the billiard
   return: true if any billiard is moving*)
let rec check_billiards_moving (billiards : billiard list) : bool =
  match billiards with
  | [] -> false
  | x :: xs -> check_ball_moving x || check_billiards_moving xs

(* [check_within_radius a b] will check if position a and position b is within
   10 units *)
let check_within_radius (a : (float * float)) (b : (float * float)) : bool =
  let ax = fst a in
  let ay = snd a in
  let bx = fst b in
  let by = snd b in
  abs_float (ax *. ax -. bx *. bx) +. abs_float (ay *. ay -. by *. by) < 100.

(* [remain_on_board b] return true if the billiard should remain on board *)
let remain_on_board (b : billiard) : bool =
  let b_pos = b.position in
  let in_pocket_status =
    check_within_radius b_pos (0.,0.) ||
    check_within_radius b_pos (0.,620.) ||
    check_within_radius b_pos (620.,0.) ||
    check_within_radius b_pos (620.,620.) ||
    check_within_radius b_pos (1240.,0.) ||
    check_within_radius b_pos (1240.,620.) in
  not in_pocket_status


(* [remove_on_board b] return true if the billiard should remove on board *)
let remove_on_board (b : billiard) : bool =
  let b_pos = b.position in
  let in_pocket_status =
    check_within_radius b_pos (0.,0.) ||
    check_within_radius b_pos (0.,620.) ||
    check_within_radius b_pos (620.,0.) ||
    check_within_radius b_pos (620.,620.) ||
    check_within_radius b_pos (1240.,0.) ||
    check_within_radius b_pos (1240.,620.) in
  in_pocket_status

(* [check_in_pot billiards] will check if there are any billards fallen into
   the pockey, and remove them *)
let rec check_in_pot (billiards : billiard list) : billiard list =
    List.filter remain_on_board billiards

(* [change_billiards_p_v billiards] update the billiard *)
let change_billiards_p_v (billiards : billiard list) : billiard list =
  let temp = List.filter check_ball_moving billiards in
  List.map move_ball_velocity temp

(* [check_foul billiards p] will decide if the user [player] have commited a foul *)
let check_foul (billiards : billiard list) (p : player) : bool =
  false (*TODO*)

(* [foul_handler st] will handle the foul case in [st] and return a new state *)
let foul_handler (st : state) : state =
  st

(* [change_state st] will change the attributes of fields in [st] and
 * update those fields to make the next change_state
   requires:
   [st] is a game state
*)
let change_state st =
  let new_on_board = change_billiards_p_v st.on_board in
  let billiards_to_be_removed = List.filter remove_on_board st.on_board in
  let check_foul = check_foul billiards_to_be_removed st.is_playing in
  if not check_foul then
    let new_on_board2 = check_in_pot new_on_board in {st with
      on_board = new_on_board2 ;
      ball_moving = check_billiards_moving new_on_board2 ;
      is_playing = st.is_playing; }
    (* TODO: colliison not handled  *)
  else
    foul_handler st



(* [next_turn st] will trigger the next turn where the user is given
   control after all balls cease movement
   requires:
   [st] is current game state
 *
 *)
let next_turn st = st
