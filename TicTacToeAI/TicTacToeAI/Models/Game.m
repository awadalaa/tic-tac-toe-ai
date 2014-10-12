//
//  Game.m
//  TicTacToeAI
//
//  Created by Alaa Awad on 10/11/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "Game.h"
#define winningScores @[@7, @56, @448, @73, @146, @292, @273, @84]
@implementation Game


- (id)init
{
	if ((self = [super init]))
	{
        // initialize 3x3 board with empty states
		self.board = [[NSMutableArray alloc] initWithCapacity:9];
        for (int y=0;y<3;y++){
            for (int x=0;x<3;x++){
                self.board[x+3*y] = [NSNumber numberWithInt: SquareState_Empty];
            }
        }
        
        self.playerTurn = PlayerTurn_X; // x always starts
	}
	return self;
}


-(int)scoreForBoard:(NSArray *)board andPlayer:(PlayerTurn)player{
    /*
     Scoring: represent each square in the 3x3 tic tac toe grid as a 9-bit value where each bit=1 represents square occupied. add the winning squares to get values in winningScores array, which holds all the 9bit values that are tic-tac-toe winners.
     
     *     273                 84
     *        \               /
     *          1 |   2 |   4  = 7
     *       -----+-----+-----
     *          8 |  16 |  32  = 56
     *       -----+-----+-----
     *         64 | 128 | 256  = 448
     *       =================
     *         73   146   292
     */
    
    int score = 0;
    int squareVal = 0;
    
    // scoring for which player?
    int playerSquare = SquareState_X;
    if (player==PlayerTurn_O)
        playerSquare = SquareState_O;
    
    for(int y=0;y<3;y++){
        for(int x=0;x<3;x++){
            squareVal = pow(2,(3*y+x)); // 3y+x gives us value between 0-8. raise 2 to this power to get 9bit squareVal
            if (board[3*y+x]==[NSNumber numberWithInt:playerSquare])
                score+=squareVal;
        }
    }
    return score;
    
}


-(BOOL)isWinForScore:(int)score{
    /*
     To tell if X wins, we pass in the 9bit value representing the X boards score (see scoreForBoard:andPlayer: comment).  Then logical AND with each of the winningScores. If result == winning score, we have a winner.
     */
    for (int i = 0; i<[winningScores count]; i++) {
        if (([winningScores[i] intValue] & score) == [winningScores[i] intValue]) {
            return YES;
        }
    }
    return NO;

    
}


@end
