open Types
open Command
open Player
open Ai
open Billiards

(* open Graphics *)
(* open Billiards *)
module Html = Dom_html
let js = Js.string
let document = Html.document
(* type billiards: see billiard.mli *)

(* type player: see player.mli *)

(* foul: see foul .mli *)

(* init state *)

(* initial state *)
(* let init = {
  on_board = [cue_ball;one_ball;two_ball; three_ball; four_ball; five_ball;
              six_ball; seven_ball; eight_ball; nine_ball; ten_ball;
              eleven_ball; twelve_ball; thirteen_ball; fourteen_ball;
              fifteen_ball;];
  cue_bearing = 0.;
  counter = 0;
  gap = 45.;
  is_collide = false;
  cue_pos = (((fst cue_ball.position) +. 45.), (snd cue_ball.position));
  is_pot = [];
  player = [player1; player2];
  ball_moving = false;
  prev_ball_moving = false;
  (* if we use multiple skins *)
  current_table_id = "default";
  foul = No_foul;
  is_playing = player1;
  hit_force = (0., 0.);
  win = 0;
  round = 0;
  billiards_removed_in_a_round = [];
  is_start = true;
  is_mult = false;
  is_test = false;

} *)


(* HELPER FUNCTION GOES BELOW *)
(* initialize basic variable *)
let radius = 15.
let playing_field = (460., 920.)
let top_bd = 160. +. radius
let bottom_bd = top_bd +. (fst playing_field) -. 2. *. radius
let left_bd = 160. +. radius
let right_bd = left_bd +. (snd playing_field) -. 2. *. radius

(* [collide b1 b2] collides two balls and changes their velocities
   requires : [b1] and [b2] are valid billiard *)
let collide (b1 : billiard) (b2 : billiard) =

(* these are the distances bewteen centers plus the radius of the balls *)
  let x1 = ref (fst (b1.position) +. radius) in
  let x2 = ref (fst (b2.position) +. radius) in
  let y1 = ref (snd (b1.position) +. radius) in
  let y2 = ref (snd (b2.position) +. radius) in

  (* these are the real distances of x coordinate and y coordinate*)
  let dx_wRadius = !x2 -. !x1 in
  let dy_wRadius = !y2 -. !y1 in

  (* the actual distance between the two balls *)
  let distance = sqrt(dx_wRadius *. dx_wRadius +. dy_wRadius *. dy_wRadius) in

  (*  distances with no overlap *)
  let dx = 2.*.radius *. dx_wRadius /. distance in
  let dy = 2.*.radius *. dy_wRadius /. distance in

  (*adjust it with changes due to size*)
    x1 := !x1 -. (dx -. dx_wRadius);
    y1 := !y1 -. (dy -. dy_wRadius);
    b1.position <- (!x1 -. radius, !y1 -. radius);

  (* distances to collision point *)
  let dx1 = (!x2 -. !x1) /. 2. in
  let dx2 = (!x2 -. !x1) /. 2. in
  let dy1 = (!y2 -. !y1) /. 2. in
  let dy2 = (!y2 -. !y1) /. 2. in

  (* [straight_v velocity_x velocity_y dx dy radius] returns the straight velocity
     to collision
     requires: [velocity_x] [velocity_y] are valid velocity
               [dx] [dy] are valid distance
              [radius] are valid radius *)
  let straight_v velocity_x velocity_y dx dy radius =
                    velocity_x *. dx /. radius +. velocity_y *. dy /. radius in

  (* [perpendicular_v velocity_x velocity_y dx dy radius] returns the perpendicular
     velocity to collision
     requires: [velocity_x] [velocity_y] are valid velocity
            [dx] [dy] are valid distance
           [radius] are valid radius *)
  let perpendicular_v velocity_x velocity_y dx dy radius =
    velocity_y *. dx /. radius -. velocity_x *. dy /. radius in

  (* [x_velocity vs vp dx dy r] returns x velocity
     requires: [velocity_st] [velocity_per] are valid velocity
            [dx] [dy] are valid distance
           [radius] are valid radius *)
  let x_velocity velocity_st velocity_per dx dy radius =
    velocity_st *. dx /. radius -. velocity_per *. dy /. radius in

  (* [y_velocity velocity_st velocity_per dx dy radius] returns y velocity
     requires: [velocity_st] [velocity_per] are valid velocity
            [dx] [dy] are valid distance
           [radius] are valid radius *)
  let y_velocity velocity_st velocity_per dx dy radius =
    velocity_st *. dy /. radius +. velocity_per *. dx /. radius in

  (* [collision_v v1 v2 m1 m2]returns velocity of a ball after collision
     requires: [vx] [vy] are valid velocity
            [dx] [dy] are valid distance
           [r] are valid radius
          [m1] [m2] are valid mass*)
  let collision_v v1 v2 m1 m2 =
    v1 *. (m1-.m2) /. (m1+.m2) +. v2 *. (2. *. m2) /. (m1 +. m2) in

  let velocity_st_1 = straight_v (fst b1.velocity) (snd b1.velocity)
      dx1 dy1 radius in
  let velocity_perpen_1 = perpendicular_v (fst b1.velocity) (snd b1.velocity)
      dx1 dy1 radius in

  let velocity_st_2 = straight_v (fst b2.velocity) (snd b2.velocity)
      dx2 dy2 radius in
  let velocity_perpen_2 = perpendicular_v (fst b2.velocity) (snd b2.velocity)
      dx2 dy2 radius in

  (*straight collision velocities *)
  let newvelocity_st_1 = collision_v velocity_st_1 velocity_st_2
      b1.mass b2.mass in
  let newvelocity_st_2 = collision_v velocity_st_2 velocity_st_1
      b2.mass b1.mass in

  (* the velocity for b1*)
  let b1_x_velocity = x_velocity newvelocity_st_1 velocity_perpen_1
      dx1 dy1 radius in
  let b1_y_velocity = y_velocity newvelocity_st_1 velocity_perpen_1
      dx1 dy1 radius in
  b1.velocity <- (b1_x_velocity, b1_y_velocity);

  (* the velocity for b2*)
  let b2_x_velocity = x_velocity newvelocity_st_2 velocity_perpen_2
      dx2 dy2 radius in
  let b2_y_velocity = y_velocity newvelocity_st_2 velocity_perpen_2
      dx2 dy2 radius in
  b2.velocity <- (b2_x_velocity, b2_y_velocity)

(* [check_wall_touching ball ] check with the balls that hit the wall and change
   their coordiante accordingly
   requires: [ball] is a valid billiard *)
let check_wall_touching ball =

  let x_left = fst ball.position in
  let y_top = snd ball.position in
  let y_bottom = snd ball.position in
  let x_right = fst ball.position in

  (*ball hit left bound*)
    if (x_left < left_bd)
    then
      begin
      ball.position <- (left_bd, snd ball.position);
      ball.velocity <- ((0.-.fst ball.velocity)*.0.99, snd ball.velocity *.0.99)
    end;
    (*ball hit top bound*)
    if (y_top < top_bd)
    then
      begin
      ball.position <- (fst ball.position, top_bd);
      ball.velocity <- (fst ball.velocity*.0.99, (0.-.snd ball.velocity)*.0.99)
    end;
    (*ball hit right bound*)
    if (x_right > right_bd)
    then
      begin
      ball.position <- (right_bd, snd ball.position);
      ball.velocity <- ((0.-.fst ball.velocity)*.0.99, snd ball.velocity*.0.99)
    end;
    (*ball hit bottom bound*)
    if (y_bottom > bottom_bd)
    then
      begin
        ball.position <- (fst ball.position, bottom_bd);
      ball.velocity <- (fst ball.velocity*.0.99, (0.-.snd ball.velocity)*.0.99)
    end;
    ball

(* [move_ball_position time ball] moves the [ball] for 1/50 second, change the
   position.
   requires: [ball] is a valid billiard *)
let move_ball_position ball =
  let tempx = (fst ball.position) +. (fst ball.velocity *. (1./.200.)) in
  let tempy = (snd ball.position) +. (snd ball.velocity *. (1./.200.)) in
  ball.position <- (tempx,tempy);
  ball

(* [move_ball_velocity time ball] slow down the velocity while [ball] is moving
   requires: [ball] is a valid billiard *)
let move_ball_velocity ball =
  let tempx = ref ( (fst ball.velocity) *. 0.983)  in
  let tempy = ref ( (snd ball.velocity) *. 0.983 )  in
  if abs_float(!tempx) < 1.5 then tempx := 0.;
  if abs_float(!tempy) < 1.5 then tempy := 0.;
  ball.velocity <- (!tempx, !tempy);
  ball

(* [check_ball_moving ball] check if the [ball] is moving,
   return: true if [ball] is moving
   requires: [ball] is a valid billiard *)
let rec check_ball_moving (ball : billiard) : bool =
  fst ball.velocity <> 0. || snd ball.velocity <> 0.

(* [check_ball_moving billiards] will check if there is any billard ball moving
   on the billiard
   return: true if any billiard is moving
   requires: [billiards] is a valid billiard list *)
let rec check_billiards_moving (billiards : billiard list) : bool =
  match billiards with
  | [] -> false
  | x :: xs -> check_ball_moving x || check_billiards_moving xs

(* [check_within_radius a b] will check if position a and position b is within
   10 units
    requires: [a] [b] is a valid float tuple
              [distance] is a valid float *)
let check_within_radius (a : (float * float)) (b : (float * float))
    (distance : float) : bool =
  let ax = fst a in
  let ay = snd a in
  let bx = fst b in
  let by = snd b in
  abs_float (((ax -. bx)) *. (ax -. bx)) +.
  abs_float (((ay -. by) *. (ay -. by))) < distance

(* [remain_on_board b] return true if the billiard should remain on board.
requries: [b] is a valid billiard *)
let remain_on_board (b : billiard) : bool =
  let b_pos = b.position in
  let distance = 100. in
  let in_pocket_status =
  check_within_radius b_pos (left_bd +. 5., top_bd +. 5.) distance ||
  check_within_radius b_pos (left_bd +. 445., top_bd +. 5.) distance ||
  check_within_radius b_pos (right_bd -. 5., top_bd +. 5.) distance ||
  check_within_radius b_pos (left_bd +. 5., bottom_bd -. 5.) distance ||
  check_within_radius b_pos (left_bd +. 445., bottom_bd -. 5.) distance ||
  check_within_radius b_pos (right_bd -. 5., bottom_bd -. 5.) distance in
  not in_pocket_status

(* [remove_on_board b] return true if the billiard should remove on board
requires: [b] is a valid billiard *)
let remove_on_board (b : billiard) : bool =
  let b_pos = b.position in
  let distance = 100. in
  let in_pocket_status =
    check_within_radius b_pos (left_bd +. 5., top_bd +. 5.) distance ||
    check_within_radius b_pos (left_bd +. 445., top_bd +. 5.) distance ||
    check_within_radius b_pos (right_bd -. 5., top_bd +. 5.) distance ||
    check_within_radius b_pos (left_bd +. 5., bottom_bd -. 5.) distance ||
    check_within_radius b_pos (left_bd +. 445., bottom_bd -. 5.) distance ||
    check_within_radius b_pos (right_bd -. 5., bottom_bd -. 5.) distance in
  in_pocket_status

(* [check_in_pot billiards] check if there are any billards fallen into
   the pockey, and remove them.
requires: [billiards] is a valid billiard list *)
let rec check_in_pot (billiards : billiard list) : billiard list =
  List.filter (remain_on_board) billiards

(* [change_billiards_p_v billiards] update the billiards' velocities
   requires: [billiards] is a valid billiard list *)
let change_billiards_velocity (billiards : billiard list) : billiard list =
  List.map move_ball_velocity billiards

(* [remove_billiard_in_list b billiards] will remove [b] in [billiards]
   requires: [b] is a valid billiard
             [billiards] is a valid billiard list *)
let rec remove_billiard_in_list (b : billiard) (billiards : billiard list)
  : billiard list =
  match billiards with
  | [] -> []
  | h :: t -> if h = b then t else h :: remove_billiard_in_list b t

(* [check_billiard_collision billiards] update the billiard velocity if
   collisions happen.
   requires: [billiards] is a valid billiard list *)
let check_billiard_collision (billiards : billiard list) : billiard list =
    for i = 0 to (List.length billiards - 1) do
      let billiard_temp = List.nth billiards i in
      for j = i + 1 to (List.length billiards - 1) do
        let billiard_temp2 = List.nth billiards j in
        if (check_within_radius
              billiard_temp.position billiard_temp2.position 900.)
        then
        collide billiard_temp billiard_temp2
      done
    done;
    billiards


(* [check_is_collide st] check all the balls in state is collide or not
   requires: [st] is a valid billiard state *)
  let rec check_is_collide_h l =
    match l with
    | h1 :: h2 :: t -> if (check_within_radius h1.position h2.position 910.)
                       && h1 <> h2 && (h1.velocity <> h2.velocity) then
            true
      else check_is_collide_h (h2::t)
    | _ -> false

let check_is_collide st : bool =
  check_is_collide_h st.on_board

let restart st =
  let command = player_command in
  if command.s then st.is_start <- false else st.is_start <- st.is_start

let do_mult st =
  let command = player_command in
  if command.w then begin st.is_start <- false; st.is_mult <- true end
  else st.is_start <- st.is_start

let do_test st =
  let command = player_command in
  if command.x then begin st.is_start <- false; st.is_test <- true end
  else st.is_start <- st.is_start

let toggle_cue st =
  let command = player_command in
  let choose_cue = command.cue in
  st.choose_cue <- choose_cue

let toggle_egg st =
  let command = player_command in
  if command.egg_counter = 42 then st.is_egg <- true
  else st.is_egg <- st.is_egg

(* let control_cue command st =
  if command.a then st.cue_bearing +. 1.
  else if command.d then st.cue_bearing -. 1.
  else st.cue_bearing *)

(* TODO: [ update_cue_bearing st ball_moving curr_bearing]
   requires: [st] is a valid state
             [ball_moving] is a valid
             [curr_bearing] is a valid *)
let update_cue_bearing st ball_moving curr_bearing =
  (* let command = player_command in *)
  let new_bearing =
  if ball_moving then 0.
  (* else if command.a then curr_bearing +. 0.5
  else if command.d then curr_bearing -. 0.5
  else if command.q then curr_bearing +. 20.
  else if command.e then curr_bearing -. 20. *)
  else curr_bearing
  in (*update this with command helper*)
  let bearing =
    if new_bearing < 0. then new_bearing +. 360.
    else new_bearing in
  bearing

(* TODO: [ get_quadrant st ]
   requires: [st] is a valid state *)
let get_quadrant (st:state) =
  let bearing = mod_float st.cue_bearing 360. in
  if bearing <= 90. then 1
  else if st.cue_bearing <= 180. then 2
  else if st.cue_bearing <= 270. then 3
  else 4

let rad d = d *. 3.1415926 /. 180.
let make_d r = r *. 180. /. 3.1415926

(* TODO: [ update_gap st ball_moving curr_bearing]
   requires: [st] is a valid state
             [ball_moving] is a valid
             [curr_bearing] is a valid *)
let update_gap st ball_moving curr_gap =
  (* let command = player_command in *)
  let new_gap =
    if ball_moving then 45.
    (* else if command.w then curr_gap -. 1.
    else if command.s then curr_gap +. 1.
    else if command.two then curr_gap -. 15.
    else if command.x then curr_gap +. 15. *)
    else curr_gap
  in
  let gap =
    if new_gap < 20. then 20.
    else if new_gap > 150. then 150.
    else new_gap
  in
  gap

(* [cue_pos_offset st gap] calculates the offset of the cue tip position
with respect to cue_ball
   requires: [st] is a valid state
             [gap] is a valid integer *)
let cue_pos_offset st gap =
  let new_gap = update_gap st st.ball_moving gap in
  let quadrant = get_quadrant st in
  let bearing = rad st.cue_bearing in
  (* let xb = fst Billiards.cue_ball.position in
  let yb = snd Billiards.cue_ball.position in *)
  if quadrant = 1 then ((new_gap *. (Pervasives.cos bearing)),
                        (new_gap *. (Pervasives.sin bearing)))
  else if quadrant = 2 then
    ((-1. *. new_gap *. (Pervasives.cos (3.1415926 -. bearing))),
     (new_gap *. (Pervasives.sin (3.1415926 -. bearing))))
  else if quadrant = 3 then
    ((-1. *. new_gap *. (Pervasives.cos (bearing -. 3.1415926))),
     (-1. *. new_gap *. (Pervasives.sin (bearing -. 3.1415926))))
  else
    ((new_gap *. (Pervasives.cos ((2. *. 3.1415926) -. bearing))),
     (-1. *. new_gap *. (Pervasives.sin ((2. *. 3.1415926) -. bearing))))

(*  [ cue_pos_offset st gap ] calculates the cue tip position with respect to
    cue_ball coordinates.
    requires: [st] is a valid state
             [gap] is a valid integer *)
let update_cue_pos st ball_moving =
  let offset = cue_pos_offset st st.gap in
  let xb = fst Billiards.cue_ball.position in
  let yb = snd Billiards.cue_ball.position in
  (* so that the cue does not collide with balls mid movement *)
  if ball_moving then (290. , 0.)
  else (xb +. (fst offset) , yb +. (snd offset))

let update_cue_cursor st ball_moving =
  let command = player_command in
  if (ball_moving || st.is_start || (st.win <> 0)) then (290. , 0.)
  else command.cue_coord

let update_cue_gap st ball_moving curr_gap =
  let command = player_command in
  if st.is_start || st.win <> 0 then curr_gap
  else
    let gap =
    sqrt ((fst command.cue_coord -. fst Billiards.cue_ball.position) ** 2. +.
          (snd command.cue_coord -. snd Billiards.cue_ball.position) ** 2.)
    -. 45. in
    if gap < 35. then 35.
    else if gap > 200. then 200.
    else gap

let update_cue_bearing_cursor st ball_moving =
  let ball_coord = Billiards.cue_ball.position in
  let command = player_command in
  let x_offset = fst command.cue_coord -. fst ball_coord in
  let y_offset = snd command.cue_coord -. snd ball_coord in
  if st.is_start || st.win <> 0 then 0.
  else if x_offset >= 0.
  then (make_d (Pervasives.atan (y_offset /. x_offset)))
  else 180. +. (make_d (Pervasives.atan (y_offset /. x_offset)))

(*  TODO: [ release_cue st  ]
    requires: [st] is a valid state *)
let release_cue st =
  let g = st.gap in
  let bearing = rad st.cue_bearing in
  let quadrant = get_quadrant st in
  let xy_kinetic =
    if quadrant = 1 then
      (-1. *. g *. (Pervasives.cos (bearing)),
       (-1. *. g *. Pervasives.sin (bearing)))
    else if quadrant = 2 then let angle = 3.1415926 -. bearing in
      (g *. (Pervasives.cos angle), (-1. *. g *. Pervasives.sin angle))
    else if quadrant = 3 then let angle = bearing -. 3.1415926 in
      (g *. (Pervasives.cos angle), (g *. Pervasives.sin angle))
    else let angle = 2. *. 3.1415926 -. bearing in
      (-1. *. g *. (Pervasives.cos angle), (g *. Pervasives.sin angle)) in
      let command = player_command in Billiards.cue_ball.velocity <-
    if (st.ball_moving || (st.is_start || st.win <> 0))
    then Billiards.cue_ball.velocity
        else
        if st.is_test ||
           ((st.is_playing.name = "player_2") && (st.is_mult = false)) then
          (* use AI *)
          begin let sound =
            if st.is_egg then "media/wilhelm_scream.mp3"
            else "media/cue.mp3" in
          let audio = Html.createAudio document in
          audio##src <- js sound;
             audio##play ();
            (* st.is_hit <- false; *)
            ai_evaluate_next_move st

          end
        else if command.cue_release then
        begin let sound =
          if st.is_egg then "media/wilhelm_scream.mp3"
          else "media/cue.mp3" in
        let audio = Html.createAudio document in
        audio##src <- js sound;
           audio##play ();

            (* st.is_hit <- true; *)
            st.hit_force <- (30. *. (fst xy_kinetic), 30. *. (snd xy_kinetic));
            (30. *. (fst xy_kinetic), 30. *. (snd xy_kinetic))
          end
        else begin Billiards.cue_ball.velocity end
(*  TODO: [ replace_cue_ball st  ]
    requires: [st] is a valid state *)
let replace_cue_ball st =
  if List.mem Billiards.cue_ball st.on_board = false then
    Billiards.cue_ball.position <- (880., 390.);
  st.on_board <- Billiards.cue_ball :: st.on_board

(*[contain_cue_ball billiards] check whether [billiards] list contains cue ball
   requires: [billiards] is valid billiard list *)
  let rec contain_cue_ball billiards =
    match billiards with
    | x::xs -> if (x.suit = 0 ) then true
      else contain_cue_ball xs
    | []-> false

(*[contain_8_ball_undone billiards] check whether the billiards list contains
  8 ball
  requires: [billiards] [player_target_balls] is valid billiard list *)
let rec contain_8_ball_undone billiards player_target_balls =
  match billiards with
  | x::xs -> if (x.suit = 8 ) && (player_target_balls <>[] ) then true
    else contain_8_ball_undone xs player_target_balls
  | []-> false

(* [check_foul billiards p] will decide if the user [player] have commited a foul
   requires: [billiards_to_be_removed] [balls_onboard] is a valid billiard list
             [p] is a valid player *)
let check_foul (billiards_to_be_removed : billiard list) (p : player)
    (balls_onboard: billiard list) : bool =
  let player_target_balls = List.filter
      (fun (b: billiard) ->
         if p.name = "player_1" then 1 <= b.suit && b.suit <= 7
         else 9 <= b.suit && b.suit <= 15) balls_onboard in
  if contain_cue_ball billiards_to_be_removed then true
  else contain_8_ball_undone billiards_to_be_removed player_target_balls

(* [find_next_player players is_playing] will find the next player aside from
   [is_playing] player.
   raises: "player not found" if next player does not exist in the list
   requires: [players] is a valid player list
             [is_playing] is a valid player*)
let rec find_next_player (players : player list) (is_playing : player) =
  match players with
  | [] -> failwith "player not found"
  | h :: t -> if h = is_playing then find_next_player t is_playing else h

(*[hit_legal_plot_ball ball_removed legalpot] returns true if the player hit the
  balls that is in the legal plot list
  requires: [ball_removed] is a valid billiard list
            [legalpot] is a valid billiard list *)
let rec hit_legal_plot_ball ball_removed legalpot=
  match ball_removed with
  | x::xs -> if List.mem x legalpot
    then true else hit_legal_plot_ball xs legalpot
  | [] -> false

(* [next_round st] will trigger the next turn where the user is given
   control after all balls cease movement
   requires: [st] is current game state
*)
let next_round (st : state) =
  let players = st.player in
  let current_player = st.is_playing in
  let another_player = find_next_player players current_player in
  let billiards_to_be_removed = st.billiards_removed_in_a_round in
  if current_player.legal_pot = [] &&
     List.mem Billiards.eight_ball billiards_to_be_removed then
    if current_player.name = "player_1"
    then st.win <- 1
    else st.win <- 2
  else
  (*not hit balls in the legal pot*)
  if not (hit_legal_plot_ball billiards_to_be_removed
            current_player.default_legal_pot) then
    begin
      current_player.is_playing <- false;
      another_player.is_playing <- true;
      st.is_playing <- another_player;
      st.round <- st.round + 1;
    end
    (*white ball in cue*)
  else if contain_cue_ball billiards_to_be_removed then
    begin
      current_player.is_playing <- false;
      another_player.is_playing <- true;
      st.is_playing <- another_player;
      st.foul <- Cue_pot;
      st.round <- st.round + 1;
    end
    (*while ball eight is not in the legal list, hit the 8 ball in it*)
  else if (contain_8_ball_undone billiards_to_be_removed
             current_player.default_legal_pot) then
    if current_player.name = "player_1"
    then begin
      st.win <- 2;
      current_player.is_playing <- false;
      another_player.is_playing <- true;
      st.foul <- Cue_eight;
    end
    else begin
      st.win <- 1;
      current_player.is_playing <- false;
      another_player.is_playing <- true;
      st.foul <- Cue_eight;
    end

let calc_score (st: state) p =
  let p_score = (17 - List.length (st.on_board)) * 100 in
  begin
    if p_score < 0 then p.score <- 0 else p.score <- p_score;
  end

let rec get_player_by_name name players =
  match players with
  |  x :: xs -> if x.name = name then x else get_player_by_name name xs
  | [] -> failwith "no such name"

let rec check_collide_w_cue_reset balls_on_board temp_cue =
  match balls_on_board with
  | x::xs -> if check_within_radius x.position temp_cue 900. then true
    else check_collide_w_cue_reset xs temp_cue
  | [] -> false

(* [change_state st] will change the attributes of fields in [st] and
 * update those fields to make the next change_state
   requires:
   [st] is a game state *)
let change_state (st: state) : state =
  (* if player still aiming, then return current state *)
  (* else make the balls move for .03 second *)
  let position_on_board = List.map move_ball_position st.on_board
                          |> List.map check_wall_touching
                          |> check_billiard_collision
                          |> change_billiards_velocity in
  let billiards_to_be_removed = List.filter remove_on_board position_on_board in
  st.billiards_removed_in_a_round <- st.billiards_removed_in_a_round
                                     @ billiards_to_be_removed;
  (* moved them here to help with my reset cue bearing *)
  let new_on_board2 = check_in_pot position_on_board in
  let ball_move = check_billiards_moving new_on_board2 in
  let check_start = (st.is_start || st.win <> 0) in
  let check_foul_result = check_foul billiards_to_be_removed
      st.is_playing new_on_board2 in
  let new_bearing = update_cue_bearing_cursor st (check_start || ball_move) in
  let new_cue_pos = update_cue_cursor st (check_start || ball_move) in
  let new_gap = update_cue_gap st (check_start || ball_move) st.gap in
  (*set legal pot *)
  let player_1 = (get_player_by_name "player_1" st.player) in
  let player_2 = (get_player_by_name "player_2" st.player) in
  player_1.legal_pot <- List.filter (fun b -> 1 <= b.suit && b.suit <= 7)
      new_on_board2;
  player_2.legal_pot <- List.filter (fun b -> 9 <= b.suit && b.suit <= 15)
      new_on_board2;

   if (player_1.legal_pot=[] && List.mem Billiards.eight_ball new_on_board2)
   then player_1.legal_pot <- [Billiards.eight_ball];
   if (player_2.legal_pot=[] && List.mem Billiards.eight_ball new_on_board2)
   then player_2.legal_pot <- [Billiards.eight_ball];

  replace_cue_ball st;
  release_cue st;
  calc_score st player1; calc_score st player2;
  restart st;
  do_mult st;
  do_test st;
  toggle_cue st;
  toggle_egg st;
  if not ball_move && (st.ball_moving = true || ball_move) then
    begin
      next_round st;
      st.billiards_removed_in_a_round<-[];
    end;
  if not check_foul_result then
    {st with
      on_board = new_on_board2 ;
      prev_ball_moving = st.ball_moving;
      ball_moving = ball_move;
      is_collide = check_is_collide st;
      cue_bearing = new_bearing;
      cue_pos = new_cue_pos;
      counter = st.counter + 1;
      gap = new_gap;
    }
  else

    (* [foul_handler st] will handle the foul in [st] and return a new state
       requires: [st] is a valid state*)
    let foul_handler (st : state) : state =
      let current_player = st.is_playing in
      let player_target_balls = List.filter
          (fun (b: billiard) -> if current_player.name = "player_1"
            then 1 <= b.suit && b.suit <= 7
            else 9 <= b.suit && b.suit <= 15) new_on_board2 in
      (* if the cue ball is removed *)
      if contain_cue_ball billiards_to_be_removed then
        (* [new_on_board_recover_cue new_on_board2] checks whether the ball
           removed is the cue, and return a new state with cue ball's position
           reset.*)
        let new_on_board_recover_cue new_on_board2 =
          let temp_cue_position = ref (880.,390.) in
          while check_collide_w_cue_reset st.on_board !temp_cue_position do
            temp_cue_position := (fst !temp_cue_position +. 30.,
                                  snd !temp_cue_position)
          done;
          Billiards.cue_ball.position <- !temp_cue_position ;
          Billiards.cue_ball.velocity <- (0.,0.);
          Billiards.cue_ball::new_on_board2 in
          {st with
           on_board = new_on_board_recover_cue new_on_board2 ;
           ball_moving = ball_move;
           cue_bearing = new_bearing;
           cue_pos = new_cue_pos;
           counter = st.counter + 1;
           gap = new_gap;
           foul = Cue_pot;
          }
      else if contain_8_ball_undone billiards_to_be_removed player_target_balls
      then
        (*if the 8 ball is removed and there are still balls to be removed *)
        if current_player.name = "player_1"
        then {st with win = 2;}
        else {st with win = 1;}
      else failwith "contain 8 balls situation not found "
       in foul_handler st

(* [get_cue_billiard billiard_list] will find the cue ball in [billiard_list]
   raises: "No cue billiard on board"
           if cue ball does not exist in [billiard_list]
   requires: [billiard_list] is a valid billiard list *)
let rec get_cue_billiard (billiard_list : billiard list) : billiard =
  match billiard_list with
  | x :: xs -> if x.suit = 0 then x
    else get_cue_billiard xs
  | [] -> failwith "No cue billiard on board"
