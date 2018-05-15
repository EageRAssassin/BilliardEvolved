# BilliardEvolved

CS 3110 Final project
Zi Heng Xu @zx223
Rong Tan @rt389
Wendy Huang @bh486

##Description
This is a top-down perspective game of media/billiards.png (pool) that pits a player against a computer AI-controlled opponent or another player. Included features include physics, a mouse-based player control, billiard mechanics, collision, and a beautiful, fully pixel-by-pixel drawn GUI. The rules are
similar to the traditional billiard rules. It is a fun game to play when
you want to relax and chill.

## How to Run
OCaml and Opam must be installed.

Prerequisites: (type these in your terminal/command prompt)
$ opam install js_of_ocaml js_of_ocaml-ocamlbuild js_of_ocaml-camlp4 js_of_ocaml-lwt

Navigate to the folder containing this game, and to Run:
$ make
$ open "index.html"
OPTIONAL: we recommend using safari since the music seems to glitch in
google chrome. Thus, use
            $ open -a safari index.html
if you are on mac


test:
$ make test

#Key Features
Fully original design of ALL graphic components, including the table, the GUI the billiards, the cue, and other graphics.
Music is copyright from Kahoot.
Interactive mouse-based GUI featuring dynamic polling and representation

THere are two game modes:
1. Single player: where a cue is aimed and controlled
by a mouse cursor, against an artificial intelligence (AI) opponent who
utilises mathematical calculations and preferential algorithm to simulate human
decision-making
2. Multiplayer: essentially two players playing agaisnt each other
(3.) A hidden game mode where if you press X in the menu page


State
Contains all parameters (information our game needs) as a single game
state. Included examples include: a mapping of every billiard position, the
current player, what billiards are on board, the current placement of
the billiard cue and the bearing (by the controlling player or the AI) etc.

GUI
This module contains all the code needed to translate the State into a
graphical representation of those parameters. Essentially, through the usage
of js_of_ocaml it uses HTML canvas and DOM to append each element. From
our media folder, images are sourced and called according to the state.

The GUI is loyal only to the state for the most part, ensuring modularity, in
that the "end justifies the means" i.e. the way in which AI works will not
change the GUI representation as long as it gives the necessary information

Command
This contains all the commands for a player. We originally used the Keyboard
but upgraded to mouse for aiming the cue. This explains the superfluous
mapping which we decided to keep since they are used for some other
trivial controls (e.g. choosing the game mode in the start screen )

Game
Using HTML's event listener, it polls the user input to feed values to state

Main
This calls the necessary javascript operations to run the game loop, which
consists of the GUI as a context being redrawn repeatedly.

AI
This module contains functions that allow the AI to evaluate its move and hit the ball with unparalleled accuracy

Room/Sprites
These modules contain the parameters to instantiate the initial player, map, and enemies.

Division of Labor
In general, Julian and Alex worked on the backend while Mindy and Tom worked on the frontend. More detail is provided below.

Julian: Primarily worked on design and State. He spent ~40 hours on this project.
Alex: Primarily worked on design and the AI, as well as implementing the ai-portion of command, and some of the functionality in State. He spent ~35 hours on this project.
Tom: Worked on design, GUI, main, game, and state files as well as crafting levels, specifically implementing Json design and parsing for state (which was removed because of unfortunate compatibility issues with js_of_ocaml), sprite animation, and map parsing/design. He spent ~45 hours on this project. The commits on Github are not representative due to issues with the VM and general laptop problems. He worked mainly through Mindy’s laptop and Github account for the 2nd half of game development.
Mindy: Worked on design, the GUI, main, game, and state files as well as crafting levels, specifically on the drawing functions in GUI and the game loop. She spent ~42 hours on this project.
Module Design
See the .mli files for the full specifications on the modules. We designed each interface file to contain and expose the most pertinent information that the other files will need to access. The types and helper files contain all of the types contained in the game and some simple helper functions respectively. The state contains a model of the game state, command contains a type to represent command input keys, as well as ways to retrieve those keys from either the player or the AI. AI contains an accessible function that allows a command to be made for an AI in the given state. Rooms and sprites files contain information about the initial state of the game. Originally the game's initial state was to be represented as a json for ease of map/game development. This would also allow for easy saving/restarting of game states. The code was written but unfortunately abandoned to a compatibility issues regarding yojson with js_of_ocaml and JavaScript.

The state contains all of the information about the game, such as the sprites (including the player), all rooms, all objects, the attack location, and the current room.

The command file contains a mutable record that updates based on the user input from the keyboard and parses it to match a command type defined. The command types represent the keys pressed, such as w, a, s, d, j. The GUI module contains all of the code and functions that render and display the content of the game state on screen for the user to see through HTML, CSS, and JavaScript converted from OCaml. Functions in Gui.ml include methods to cycle through sprite sheets, match specific images to room records, create a DOM for web display, and more. The Game module contains functions required for sprite animation, game looping, and listeners for browser key commands. Moreover the initial maps, sprites, obstacles, textures, enemy sprites, weapons, and entrances and exits to other rooms are congregated into the beginning state of the game in this module. The room and sprite modules contain the actual records for rooms and sprites with the necessary starting parameters to remove noise from the game module.

AI
The AI module's most important method is ai_evaluate_next_move, which uses our AI to analyze the current state to produce the optimal velocity (x velocit, y velocity) of the cue and which billiard to hit towards which pocket to play against the player.
AI's strategy is listed in the following:
   1. If all balls are on board, hit the nearest billiard from the AI's
      legal pot with full force
   2. Search for all balls that can be hit directly,
      Find the ball that is closest to its pocket, and hit it
      PS: the ball is between the pocket and the cue ball
   3. Search for the AI's balls that is nearest to the cue ball and hit it

External Dependencies
For the GUI, Oscigen’s js_of_ocaml library was incorporated to translate OCaml code to browser-based Javascript for accessibility.

Acknowledgements
The sprite sheets we used are from wiizelda.net and WWCZ.info, and we referenced MariOCaml, a fall 2015 CS 3110 project, for our GUI and animation code. The audio is taken from YouTube. The font used in the game is  , and is from DarkAngelX on DeviantArt. All rights go to their respective creators.

Authors
This was built for Cornell University's CS 3110 Spring 2018 final project and was built by:

Zi Heng Xu @zx223
Rong Tan @rt389
Wendy Huang @bh486
