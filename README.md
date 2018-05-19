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

In the start, choose to play against an AI by pressing S and against a player
by pressing w.

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

Division of Labor
In general, Rong worked on the AI and testing, Wendy worked on the physics module, basic logistics (fouls and change turns), testing, and Zi Heng drew & implemented the GUI and controls

State
The state contains the functions for change turns of player, check fouls, and a fully functional physics module. For now the state will check whether two fouls happen: cue ball in pot and illegal eight ball in pot. And it would change the turns of the player accordingly. 
The physics module's functionality is listed as follows:
1. For every frame in the game, all the balls moving will update their position after adding up the multiplication of 1/200 second and their velocity, and make the velocities to be 98.3% of the original velocities, so that all the balls are moving naturally due to friction. If their velocity is dropped below 1.5, it will be set to 0.  
2. For every frame in the game, all the balls moving will check if they have touched the four walls. If they touched any, they will reverse direction in corresponding dimension, and decrease their velocity to 0.99 of their original velocity due to friction.
3. For every frame in the game, all the balls moving will check if they have contact with other balls. If so, the 2 corresponding balls will use our collide function to commit a kinetic energy transfer and update their velocities.  

Rong Tan: implemented and tested the AI module in the Billiard Evolved Game. Also participated in the debugging process in the game model and public beta testing of the game.
Estimated hours of working: 50 hours
Ziheng Xu: drawn all models for the GUI and implemented and tested the GUI module using Js_of_Ocaml. Implemented the game loop and player controls (commands)
Estimated hours of working: 50 hours
Wendy Huang: implemented and tested the physics module and game model in the Billiard Evolved Game
Estimated hours of working: 50 hours


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
The music is from Kahoot.
The game draws inspiration from Facebook's 8-ball pool in that it bears a
slight resemblance to its GUI.
The inspiration for designing physics model for detecting and handing balls collision comes from the online forum StackOverFlow.
Oxcigen's Js_of_Ocaml is used heavily, and some basic type declaractions (such
  as the headers, the DOM HTML, appendchild were referenced from his
  demos, specifically his minesweeper.ml, which he declared to be public
  and open source. )

Authors
This was built for Cornell University's CS 3110 Spring 2018 final project and was built by:

Zi Heng Xu @zx223
Rong Tan @rt389
Wendy Huang @bh486
