# BilliardEvolved

CS 3110 Final project
Zi Heng Xu @zx223
Rong Tan @rt389
Wendy Huang @bh486

##Description
This is a top-down perspective game of media/billiards.png (pool) that pits a player against a computer AI-controlled
opponent, which include features of physics, player control, billiard mechanics, collision, GUI, and new game modes. The rules are similar to the traditional billiard rules. It is a fun game to play when you want to relax and chill.

## How to Run
OCaml and Opam must be installed.

Prerequisites:
$ opam install js_of_ocaml js_of_ocaml-ocamlbuild js_of_ocaml-camlp4 js_of_ocaml-lwt

Run:
$ make
$ open "index.html"

test:
$ make test

#Key Features
Original design of the media/billiards.png, table, and other graphics
Interactive Web-based GUI
Cue controlled by keyboard, with an aiming helper
an artificial intelligence (AI) opponent
media/billiards.png rules(hit balls, foul) simulated
System Design
media/billiards.png
Modules
State
This module records the status of the game at any given time. This will allow the game to be run continuously, and updates for each move or change to the state, such as movement. This acts as the model of the model-view-controller design.

Command
This module contains the functions needed to let a user play the game, as well as calling the AI for move inputs. The AI will input commands exactly like the player for code reusability, in this way adding additional enemy types or players would be very easy.

GUI
This module contains the code necessary for the visual implementation of the backend and will update to reflect visual changes in the state. This acts as the view of the MVC design.

Game
This module executes the game loop and calls updates to state and drawing based on the player inputs. This acts as the controller of the MVC design.

Main
This module runs the game by calling the necessary Javascript animation functions. It calls the game loop and adds the canvas and basic HTML elements to the page.

AI
This module contains functions that allow the AI to evaluate its move and hit the ball with unparalleled accuracy

State
The state contains the functions for change turns of player, check fouls, and a fully functional physics module. The physics module's functionality is listed as follows:
1. For every frame in the game, all the balls moving will update their position after adding up the multiplication of 1/200 second and their velocity, and make the velocities to be 98.3% of the original velocities, so that all the balls are moving naturally due to friction. If their velocity is dropped below 1.5, it will be set to 0.  
2. For every frame in the game, all the balls moving will check if they have touched the four walls. If they touched any, they will reverse direction in corresponding dimension, and decrease their velocity to 0.99 of their original velocity due to friction.
3. For every frame in the game, all the balls moving will check if they have contact with other balls. If so, the 2 corresponding balls will use our collide function to commit a kinetic energy transfer and update their velocities.  


Division of Labor
Rong Tan: implemented and tested the AI module in the Billiard Evolved Game. Also participated in the debugging process in the game model and public beta testing of the game.
Estimated hours of working: 50 hours
Ziheng Xu: drawn all models for the GUI and implemented and tested the GUI module using Js_of_Ocaml. Implemented the game loop and player controls (commands)
Estimated hours of working: 50 hours
Wendy Huang: implemented and tested the physics module and game model in the Billiard Evolved Game
Estimated hours of working: 50 hours


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
The sprite sheets we used are from wiizelda.net and WWCZ.info, and we referenced MariOCaml, a fall 2015 CS 3110 project, for our GUI and animation code. The audio is taken from YouTube. The font used in the game is Triforce, and is from DarkAngelX on DeviantArt. All rights go to their respective creators.

Authors
This was built for Cornell University's CS 3110 Spring 2018 final project and was built by:

Zi Heng Xu @zx223
Rong Tan @rt389
Wendy Huang @bh486
