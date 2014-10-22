Tic-Tac-Toe-AI
==============

I was recently challenged with the task of writing a game of tic tac toe with an unbeatable AI. This version works on both iPhone and iPad devices. If you want to get schooled give it a shot :D

Tic tac toe is a two-player zero-sum game. By this, I mean the gain of one player is balanced perfectly by the loss of the other player and vice versa. These kinds of problems can be solved with the minimax theorem which is closely related to linear programming duality, or with Nash equilibrium.


Minimax Algorithm
================
The minimax algorithm often used in decision theory and game theory uses the fact that the two players are working towards opposite goals to make predictions.  So we evaluate a point system for each player:
- if you win +10 
- if you lose -10 
- if nobody wins 0

Tic tac toe has 9 squares so the possible combinations are 9! which means it is possible to process all outcomes in a reasonable amount of time. Given this fact, from any point in the game we can make a tree of all possible combinations and assign a score at each node based on the assumption that each player will want the maximum score from that nodes children. This can be done with a recursive method for assigning the score at each node.  There is a method in Game.m file that accomplishes this task.
