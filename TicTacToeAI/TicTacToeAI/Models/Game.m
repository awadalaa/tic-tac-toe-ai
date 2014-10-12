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



/** MiniMax Algorithm **/

-(int)miniMaxScoreForBoard:(NSArray *)board andPlayer:(PlayerTurn)player{
    if (player==PlayerTurn_X && [self isWinForScore:[self scoreForBoard:board andPlayer:player]]){
        return 10;
    }else if (player==PlayerTurn_O && [self isWinForScore:[self scoreForBoard:board andPlayer:player]]){
        return -10;
    }else{
        return 0;
    }
}


-(int)miniMaxForCurrentBoard:(NSArray *)currentBoard andCurrentPlayer:(PlayerTurn)player{
    
    int perfectChoice=-1;
    // if someone has already won, just return
    int score = -1;
    score =[self miniMaxScoreForBoard:currentBoard andPlayer:player];
    if (score!=0) return perfectChoice;
    
    
    
    NSMutableArray *scores = [[NSMutableArray alloc] init];
    NSMutableArray *moves = [[NSMutableArray alloc] init];
    NSMutableArray *tempBoard = [NSMutableArray arrayWithArray:[currentBoard copy]];
    PlayerTurn      tempPlayer = player;
    
    // get all available moves
    // 1 deep lookup
    for (int y=0;y<3;y++){
        for (int x=0;x<3;x++){
            if (currentBoard[3*y+x]==[NSNumber numberWithInt:SquareState_Empty]){
                // temporarily store perfectChoice here. will either be replaced or will be correct value
                perfectChoice = 3*y+x;
                
                // populate moves array with possible move at x,y
                [moves addObject:[NSNumber numberWithInt:3*y+x]];
                tempBoard[3*y+x] = [NSNumber numberWithInt:SquareState_X];
                
                // populate score array with minimax score from possible move at x,y
                score = [self miniMaxScoreForBoard:tempBoard andPlayer:PlayerTurn_X];
                [scores addObject:[NSNumber numberWithInt:score]];
                
                // revert tempBoard back
                tempBoard[3*y+x] = [NSNumber numberWithInt:SquareState_Empty];
                
                if (score==10){
                    return perfectChoice;
                }
            }
        }
    }
    return perfectChoice;
}

@end
