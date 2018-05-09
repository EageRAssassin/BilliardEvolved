open Types
open Command


(* type billiards: see billiard.mli *)

(* type player: see player.mli *)

(* foul: see foul .mli *)

(* HELPER FUNCTION GOES BELOW *)

let radius = 15.

(* [collide b1 b2]Collides two balls and changes their velocities accordingly
   requires : b1 and b2 are valid billiard records *)
let collide (b1 : billiard) (b2 : billiard) =
(* distances to bewteen centers and collision *)
  let x1 = ref (fst (b1.position) +. radius) in
  let x2 = ref (fst (b2.position) +. radius) in
  let y1 = ref (snd (b1.position) +. radius) in
  let y2 = ref (snd (b2.position) +. radius) in
  (* real distances (collision overlap) *)
  let dxR = !x2 -. !x1 in
  let dyR = !y2 -. !y1 in
  (* gets the ACTUAL distance between the two balls *)
  let distance = sqrt(dxR *. dxR +. dyR *. dyR) in

  (* RadSum adds radii, this gives the ideal distance *)
  (* imaginary distances (no overlap) *)
  let dx = 2.*.radius *. dxR /. distance in
  let dy = 2.*.radius *. dyR /. distance in

  (*   so that things dont look screwy when we have a fast tiny ball collide with
a slow big one we want it to be the small ball that will have its position adjusted *)

    x1 := !x1 -. (dx -. dxR);
    y1 := !y1 -. (dy -. dyR);
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
  let perpendicular_Velocity vx vy dx dy r =  vy *. dx /. r -. vx *. dy /. r in
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
  let newVs1 = collision_Velocity vs1 vs2 b1.mass b2.mass in
  let newVs2 = collision_Velocity vs2 vs1 b2.mass b1.mass in

  (* now we get new X and Y velocities for each, using the new straight velocity
     and the unaffected perpendicular velocity component *)
  let vxx_new = x_Velocity newVs1 vp1 dx1 dy1 radius in
  let vxy_new = y_Velocity newVs1 vp1 dx1 dy1 radius in
  b1.velocity <- (vxx_new, vxy_new);

  let vyx_new = x_Velocity newVs2 vp2 dx2 dy2 radius in
  let vyy_new = y_Velocity newVs2 vp2 dx2 dy2 radius  in
  b2.velocity <- (vyx_new, vyy_new)

(* deal with any balls that are hitting the sides *)
let check_wall_touching ball =
  let radius = 15. in
  let x_left = fst ball.position in
  let y_top = snd ball.position in
  (* Py measures the top left coord of ball, so we add two radii *)
  let y_bottom = snd ball.position +. 2. *. radius in
  (* to get the bottom and right y and x coords. *)
  let x_right = fst ball.position +. 2. *. radius in

    if (x_left < 80.)
    then
      begin
      ball.position <- (80., snd ball.position);
      ball.velocity <- ((0.-.fst ball.velocity)*.0.9, snd ball.velocity *.0.9)
      end;
    if (y_top < 80.)
    then
      begin
      ball.position <- (fst ball.position, 80.);
      ball.velocity <- (fst ball.velocity*.0.9, (0.-.snd ball.velocity)*.0.9)
      end;
    if (x_right > 980.)
    then
      begin
      ball.position <- (980. -. 2.*.radius, snd ball.position);
      ball.velocity <- ((0.-.fst ball.velocity)*.0.9, snd ball.velocity*.0.9)
      end;
    if (y_bottom > 535.)
    then
      begin
      ball.position <- (fst ball.position, 535. -. 2.*.radius);
      ball.velocity <- (fst ball.velocity*.0.9, (0.-.snd ball.velocity)*.0.9)
    end;
    ball

(* [move_ball_position time ball] moves the [ball] for [time] second, change the position
   requires: [ball] is a valid billiard,
             [time] is a valid int*)
let move_ball_position ball =
  let tempx = (fst ball.position) +. (fst ball.velocity *. (1./.50.)) in
  let tempy = (snd ball.position) +. (snd ball.velocity *. (1./.50.)) in
  ball.position <- (tempx,tempy);
  ball

(* [move_ball_velocity time ball] moves the [ball] for [time] second, change the velocity
   requires: [ball] is a valid billiard*)
let move_ball_velocity ball =
  let tempx = ref ( (fst ball.velocity) *. 0.95 )  in
  let tempy = ref ( (snd ball.velocity) *. 0.95 )  in
  if abs_float(!tempx) < 1. then tempx := 0.;
  if abs_float(!tempy) < 1. then tempy := 0.;
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
let check_within_radius (a : (float * float)) (b : (float * float)) (distance : float) : bool =
  let ax = fst a in
  let ay = snd a in
  let bx = fst b in
  let by = snd b in
  abs_float ((ax -. bx) *. (ax -. bx))+. abs_float ((ay -. by) *. (ay -. by)) < distance

(* [remain_on_board b] return true if the billiard should remain on board *)
let remain_on_board (b : billiard) : bool =
  let b_pos = b.position in
  let distance = 1. in
  let in_pocket_status =
    check_within_radius b_pos (80.,80.) distance ||
    check_within_radius b_pos (535.,80.) distance ||
    check_within_radius b_pos (980.,80.) distance ||
    check_within_radius b_pos (80.,535.) distance ||
    check_within_radius b_pos (535.,535.) distance ||
    check_within_radius b_pos (980.,535.) distance in
  not in_pocket_status

(* [remove_on_board b] return true if the billiard should remove on board *)
let remove_on_board (b : billiard) : bool =
  let b_pos = b.position in
  let distance = 1. in
  let in_pocket_status =
  check_within_radius b_pos (80.,80.) distance ||
  check_within_radius b_pos (535.,80.) distance ||
  check_within_radius b_pos (980.,80.) distance ||
  check_within_radius b_pos (80.,535.) distance ||
  check_within_radius b_pos (535.,535.) distance ||
  check_within_radius b_pos (980.,535.) distance in
  in_pocket_status

(* [check_in_pot billiards] will check if there are any billards fallen into
   the pockey, and remove them *)
let rec check_in_pot (billiards : billiard list) : billiard list =
    List.filter remain_on_board billiards

(* [change_billiards_p_v billiards] update the billiard *)
let change_billiards_velocity (billiards : billiard list) : billiard list =
  List.map move_ball_velocity billiards

(* [remove_billiard_in_list b billiards] will remove [b] in [billiards] *)
let rec remove_billiard_in_list (b : billiard) (billiards : billiard list) : billiard list =
  match billiards with
  | [] -> []
  | h :: t -> if h = b then t else h :: remove_billiard_in_list b t

(* [check_billiard_collision billiards] update the billiard velocity if
   collisions happen *)
let check_billiard_collision (billiards : billiard list) : billiard list =
  (* let check_collision_helper (b : billiard) : billiard =
    let billiards_besides_checked = remove_billiard_in_list b billiards in
    List.fold_left
      (fun (acc_b:billiard) (rec_b:billiard) ->
         if (check_within_radius acc_b.position rec_b.position 450.) then
           collide acc_b rec_b;
         acc_b)
      b billiards_besides_checked
    in
     List.map check_collision_helper billiards *)
    for i = 0 to (List.length billiards - 1) do
      let billiard_temp = List.nth billiards i in
      for j = i + 1 to (List.length billiards - 1) do
        let billiard_temp2 = List.nth billiards j in
        if (check_within_radius billiard_temp.position billiard_temp2.position 450.) then
          collide billiard_temp billiard_temp2
      done
    done;
    billiards


(* [check_foul billiards p] will decide if the user [player] have commited a foul *)
let check_foul (billiards_to_be_removed : billiard list) (p : player) : bool =
  false (*TODO*)

(* [foul_handler st] will handle the foul case in [st] and return a new state *)
let foul_handler (st : state) : state =
  st

(* [change_state st] will change the attributes of fields in [st] and
 * update those fields to make the next change_state
   requires:
   [st] is a game state
*)
let change_state (st: state) : state =
  (* if player still aiming, then return current state *)
  if st.player_aiming then st else
  (* else make the balls move for .03 second *)
  let position_on_board = List.map move_ball_position st.on_board
                          |> List.map check_wall_touching
                          |> check_billiard_collision
                          |> change_billiards_velocity in
  let billiards_to_be_removed = List.filter remove_on_board position_on_board in
  let check_foul = check_foul billiards_to_be_removed st.is_playing in
  if not check_foul then
    let new_on_board2 = check_in_pot position_on_board in
    {st with
      on_board = new_on_board2 ;
      ball_moving = check_billiards_moving new_on_board2 ;
      is_playing = st.is_playing; }
  else
    foul_handler st

(* [change_force st] will change the attributes of hit_force in [st] according
   to the attribute [direction]
   direction: 1 -> up; 2 -> left; 3 -> down; 4 -> right;
   requires:
   [st] is a game state
   [direciton] is a integer value from 1 and 4
*)
let change_force (st : state) (direction : int) : state =
  let original_hit_force = st.hit_force in
  let result_h_f =
    if direction = 1 then (fst original_hit_force , (snd original_hit_force) +. 1.)
    else if direction = 2 then ((fst original_hit_force) -. 1. , snd original_hit_force)
    else if direction = 3 then (fst original_hit_force , (snd original_hit_force) -. 1.)
    else if direction = 4 then ((fst original_hit_force) +. 1. , snd original_hit_force)
    else failwith "direction attribute error" in
  {st with hit_force = result_h_f;}

(* [get_cue_billiard billiard_list] will find the cue ball in the [billiard_list]
   raises: "No cue billiard on board" if cue ball does not exist in [billiard_list] *)
let rec get_cue_billiard (billiard_list : billiard list) : billiard =
  match billiard_list with
  | x :: xs -> if x.suit = 0 then x
    else get_cue_billiard xs
  | [] -> failwith "No cue billiard on board"

(* [apply_force st] will apply the foce in [st]'s hit_force to the cue ball,
   and start to make the billiards move *)
let apply_force (st : state) : state =
  let hit_force = st.hit_force in
  let cue_ball = get_cue_billiard st.on_board in
  cue_ball.velocity <- hit_force;
  {st with hit_force = (0., 0.);
           player_aiming = false;}

(* [find_next_player players is_playing] will find the next player aside from
   [is_playing] player.
   raises: "player not found" if next player does not exist in the list *)
let rec find_next_player (players : player list) (is_playing : player) =
  match players with
  | [] -> failwith "player not found"
  | h :: t -> if h = is_playing then find_next_player t is_playing else h

(* [next_turn st] will trigger the next turn where the user is given
   control after all balls cease movement
   requires: [st] is current game state
 *)
let next_turn st =
  (* change the player *)
  let players = st.player in
  let current_player = st.is_playing in
  let next_player = find_next_player players current_player in
  let current_player_changed = {current_player with is_playing = false;} in
  let next_player_changed = {next_player with is_playing = true;} in
  {st with is_playing = next_player_changed;
           player = [current_player_changed ; next_player_changed];
           player_aiming = true;}
