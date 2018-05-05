open Types
(* acknolwedgement: uses oxcigen's js_of_ocaml module found here
   https://github.com/ocsigen/js_of_ocaml
*)


(* js_of_ocaml helper declarations *)
module Html = Dom_html
let js = Js.string
let document = Html.document

(************************ DOM HELPERS ************************)

(* [fail] is a failure/exception handler *)
let fail = fun _ -> assert false



(************************ START GAME ************************)
(* acknolwedgement: usage of Dom.appendChild references
   Oxcigen's minesweeper.ml game inside /examples/minesweeper inside
   https://github.com/ocsigen/js_of_ocaml

   Note: Oxcigen declared his minesweeper.ml and main.ml to be
   open source and public domain
*)

(* [main ()] is the main method of the entire game. *)
let main () =
  (* [get_element_by_id id] gets a DOM element by its id *)
  let get_element_by_id id =
    Js.Opt.get (Html.document##getElementById (js id)) fail in
  (* [append_text e s] appends string s to element e *)
  let append_text e s =
    Dom.appendChild e (document##createTextNode (js s)) in
  let gui = get_element_by_id "gui" in
  gui##style##cssText <- js "font-family:Triforce";
  let h1 = Html.createH1 document in
  let p = Html.createP document in
  (*audio*)
  append_text h1 "Billiards Evolved";
  (*font*)
  Dom.appendChild gui h1;
  Dom.appendChild gui p;
  let canvas = Html.createCanvas document in
  canvas##width <- int_of_float Gui.canvas_width;
  canvas##height <- int_of_float Gui.canvas_height;
  Dom.appendChild gui canvas;
  let context = canvas##getContext (Html._2d_) in
  Game.game_loop context false

(* start the game *)
let _ = main ()
