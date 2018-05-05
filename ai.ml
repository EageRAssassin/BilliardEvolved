open Types

(* [distance_between position1 position2] will return the distance between
   two balls, with position1 and position2 *)
let distance_between (position1 : (float*float)) (position2 : (float*float)) : float =
  let x1 = fst position1 in
  let y1 = snd position1 in
  let x2 = fst position2 in
  let y2 = snd position2 in
  sqrt ((abs_float (x1 -. x2)) *. (abs_float (x1 -. x2))
        +. (abs_float (y1 -. y2)) *. (abs_float (y1 -. y2)))

(* [min_distance_to_pocket position1] will return the minimal distance from
   billiard [position] to pocket *)
let min_distance_to_pocket (position : (float*float)) : float =
  (*TODO location of pockets? *)
  let distance1 = distance_between position (0.,0.) in
  let distance2 = distance_between position (0.,620.) in
  let distance3 = distance_between position (620.,0.) in
  let distance4 = distance_between position (620.,620.) in
  let distance5 = distance_between position (1240.,0.) in
  let distance6 = distance_between position (1240.,620.) in
  let find_min (acc : float) (b : float) : float = if acc > b then b else acc in
  List.fold_left find_min 1387. [distance1;distance2;distance3;distance4;distance5;distance6]

(* [billiard_between position1 position2] will return true if there are
   billiards between two balls of position1 and position2
   requires: billiards is a list with valid billiards
*)
let rec billiard_between (position1 : (float*float)) (position2 : (float*float)) (billiards : billiard list) : bool =
  (* y = mx + b *)
  let x1 = fst position1 in
  let y1 = snd position1 in
  let x2 = fst position2 in
  let y2 = snd position2 in
  let m = (y2 -. y1) /. (x2 -. x1) in
  let b = y1 -. m *. x1 in
    let rec billiard_between_helper function_m function_b (billiard_list : billiard list) =
      match billiard_list with
      | x :: xs ->
        let b_x = fst x.position in
        let b_y = snd x.position in
        let distance_to_line = abs_float (m *. b_x +. (-1.0) *. b_y +. b) /. sqrt(m *. m +. 1.) in
        (* TODO billiard's radius to be 30? *)
        (distance_to_line < 30. && b_x > (min x1 x2) && b_x < (max x1 x2)
         && b_y > (min y1 y2) && b_y < (max y1 y2))
        || billiard_between_helper function_m function_b xs
      | [] -> false in
  billiard_between_helper m b billiards

(* [find_distances_from white_position billiard_list] will return a list with
   1. The distances of all the balls to the nearest pocket,
   if there is no ball between the ball and the white ball
   2. -1 if there is ball between the ball and the white ball
*)
let rec find_pocket_distances_from (white_position : (float*float)) (billiard_list : billiard list) (all_billiards : billiard list) : float list=
  match billiard_list with
  | x :: xs -> if billiard_between white_position x.position all_billiards
    then -1.0 :: find_pocket_distances_from white_position xs all_billiards
    else (min_distance_to_pocket x.position) :: find_pocket_distances_from white_position xs all_billiards
  | [] -> []

(* [find_pocket_distances_from_bouncing_wall white_position billiard_list]
   will return a list with
   1. The distances of all the balls to the nearest pocket,
   if there is no ball between the ball and the white ball with one bounce
   2. -1 if there is ball between the ball and the white ball
*)
let rec find_pocket_distances_from_bouncing_wall (white_position : (float*float)) (billiard_list : billiard list) (all_billiards : billiard list) : float list=
  match billiard_list with
  | x :: xs ->
    (* check bouncing with 4 walls *)
    (*TODO dimension of wall?*)
    let hit_feasible_by_bouncing = billiard_between white_position (-.(fst x.position), snd x.position) all_billiards ||
                                   billiard_between white_position (fst x.position, -.(snd x.position)) all_billiards ||
                                   billiard_between white_position (920.*.2.-.(fst x.position), snd x.position) all_billiards ||
                                   billiard_between white_position (fst x.position, 460.*.2.-.(snd x.position)) all_billiards in
    if hit_feasible_by_bouncing
    then -1.0 :: find_pocket_distances_from_bouncing_wall white_position xs all_billiards
    else (min_distance_to_pocket x.position) :: find_pocket_distances_from_bouncing_wall white_position xs all_billiards
  | [] -> []

(* [find_billiard_position st suit] will return the coordinate of the billiard
   with suit [suit] among billiards [billiard_list], returns (-1, -1) if
   there is not such ball in the state
   requires: billiard_list is a list with valid billiards *)
let rec find_billiard_position (billiard_list : billiard list) (suit : int) : (float * float) =
  match billiard_list with
  | x :: xs -> if x.suit = suit then x.position
    else find_billiard_position xs suit
  | [] -> (-1.0, -1.0)

(* [findnth_billiard distance_list distance index] will return the position of
   the billiard in the [distance_list] with distance [distance] *)
let rec findnth_billiard (distance_list : float list) (distance : float) (index : int): int =
  match distance_list with
  | [] -> failwith "billiard not found in findnth"
  | x :: xs -> if x = distance then index else findnth_billiard xs distance (index + 1)

(* [search1_possible st] will evaluate the whether the strategy in search1
   is possible, and return the suit of the ball if the strategy is possible.
   It returns -1 if the strategy is impossible
   returns: the suit of the ball if the strategy is possible, -1 if impossible
   requires: [st] is a valid state *)
let search1_possible st : int =
  let white_position = find_billiard_position st.on_board 0 in
  let billiards_on_board = List.filter (fun b -> b.suit <> 0) st.on_board in
  if List.length billiards_on_board > 0 then
    let distance_list : float list = find_pocket_distances_from white_position billiards_on_board billiards_on_board in
    (* check if any ball is hittable in distance list *)
    let nearest = List.fold_left (fun acc e -> if e < acc then e else acc) 2000. distance_list in
    if nearest < 2000. then findnth_billiard distance_list nearest 0
    else -1
  else failwith "No billiards on board"

(* [search2_possible st] will evaluate the whether the strategy in search2
   is possible, and return the suit of the ball if the strategy is possible.
   It returns -1 if the strategy is impossible
   returns: the suit of the ball if the strategy is possible, -1 if impossible
   requires: [st] is a valid state *)
let search2_possible st : int =
  let white_position = find_billiard_position st.on_board 0 in
  let billiards_on_board = List.filter (fun b -> b.suit <> 0) st.on_board in
  if List.length billiards_on_board > 0 then
    let distance_list : float list = find_pocket_distances_from_bouncing_wall white_position billiards_on_board billiards_on_board in
    (* check if any ball is hittable in distance list *)
    let nearest = List.fold_left (fun acc e -> if e < acc then e else acc) 4000. distance_list in
    if nearest < 4000. then findnth_billiard distance_list nearest 0
    else -1
  else failwith "No billiards on board"

(* [search1_calculation white_position ball_position] will return the x and y
   angles that aI needs to hit [ball_position] from [white_position] directly *)
(* TODO *)
let search1_calculation (white_position : (float*float)) (ball_position : (float*float)) : (float*float) =
  (fst ball_position -. fst white_position , snd ball_position -. snd white_position)

(* [search2_calculation white_position ball_position] will return the x and y
   angles that AI needs to hit [ball_position] from [white_position] directly *)
(* TODO *)
let search2_calculation (white_position : (float*float)) (ball_position : (float*float)) : (float*float) =
  (fst ball_position -. fst white_position , snd ball_position -. snd white_position)

(* AI strategy
   1. Search for all balls that can be hit directly,
      Find the ball that is closest to its pocket, and hit it
   2. Search for the balls that can be hit with one collision with the wall
      Find the ball that is closest to its pocket, and hit it
   3. Search for the AI's balls that is nearest to the white ball and hit it
*)

(* [ai_evaluate_next_move st] will use our AI to analyze the current
 * state to produce the optimal velocity (x velocit, y velocity) of the
   cue and which billiard to hit towards which pocket to play against
   the player
   requires:
   [st] is a state
*)
let ai_evaluate_next_move st : ( float * float )=
  (* check if first search method will work *)
  let search1 = search1_possible st in
  let white_position = find_billiard_position st.on_board 0 in
  if search1 <> -1 then
    let ball_position = find_billiard_position st.on_board search1 in
    search1_calculation white_position ball_position
  else
  (* check if second search method will work *)
  let search2 = search2_possible st in
  if search2 <> -1 then
    let ball_position = find_billiard_position st.on_board search2 in
    search2_calculation white_position ball_position
  else
  (* use third method *)
    search1_calculation white_position (0.0, 0.0)
      (* TODO *)
