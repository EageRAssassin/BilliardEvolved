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

(* [get_element_by_id id] gets a DOM element by its id *)
let get_element_by_id id =
  Js.Opt.get (Html.document##getElementById (js id)) fail
(* [append_text e s] appends string s to element e *)
let append_text e s =
  Dom.appendChild e (document##createTextNode (js s))

(* [main ()] is the main method of the entire game. *)
let main () =
  let gui = get_element_by_id "gui" in
  gui##style##cssText <- js "font-family:Triforce";
  let h1 = Html.createH1 document in
  (* append_text h1 "media/billiards.png Evolved"; *)
  let p = Html.createP document in
  (*audio*)
  let audio = Html.createAudio document in
    audio##src <- js "media/billiards.mp3";
    (* audio##play (); *)
  (*font*)
  Dom.appendChild gui h1;
  Dom.appendChild gui p;
  let canvas = Html.createCanvas document in
  canvas##width <- int_of_float Gui.canvas_width;
  canvas##height <- int_of_float Gui.canvas_height;
  Dom.appendChild gui canvas;
  let context = canvas##getContext (Html._2d_) in
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler Game.keydown)
      Js._true in
  let _ = Html.addEventListener
      document Html.Event.keydown (Html.handler Game.keyup)
      Js._true in
  let _ = Html.addEventListener
      document Html.Event.mousemove (Html.handler Game.mousemove)
      Js._true in
  let _ = Html.addEventListener
      document Html.Event.mousedown (Html.handler Game.mousedown)
      Js._true in
  let _ = Html.addEventListener
      document Html.Event.mouseup (Html.handler Game.mouseup)
      Js._true in
  Game.game_loop context false

(* start the game *)
let _ = main ()
