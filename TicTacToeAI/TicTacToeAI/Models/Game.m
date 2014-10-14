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

#pragma mark - scoring methods
-(int)scoreForPlayer:(PlayerTurn)player{
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
            if (self.board[3*y+x]==[NSNumber numberWithInt:playerSquare])
                score+=squareVal;
        }
    }
    return score;
    
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


#pragma mark - minimax algorithm
-(int)minimaxWithGameBoard:(NSArray *)board forPlayer:(PlayerTurn)player{
    
    if ([self isWinForScore:[self scoreForBoard:board andPlayer:player]]){
        //NSLog(@"For Player X final board is worth:@%d",[self evaluateMiniMaxForBoard:board andPlayer:PlayerTurn_X]);
        return [self evaluateMiniMaxForBoard:board andPlayer:PlayerTurn_X];
    }

    int perfectChoice = -1;
    int score = -10;

    NSArray *moves = [self movesAvailableInBoard:board];
    id enumerator = [moves objectEnumerator];
    id m;
    while (m = [enumerator nextObject]) {
        /* code to act on each element in available moves array */
        int move = [m intValue];
        //NSLog(@"move %d for player %@",(int)move, player==PlayerTurn_X?@"X":@"O");

        NSMutableArray *newboard = [board mutableCopy];
        newboard[move]=(player==PlayerTurn_X)?[NSNumber numberWithInt:SquareState_X]:[NSNumber numberWithInt:SquareState_O];
        //NSLog(@"newboard %@",newboard);
        
        int nextGameScore = -[self minimaxWithGameBoard:newboard forPlayer:!player];
        if (nextGameScore > score) {
            perfectChoice = move;
            score = nextGameScore;
        }
    }
    return (int)perfectChoice;
}



-(NSArray *)movesAvailableInBoard:(NSArray *)board{
    NSMutableArray *moves = [[NSMutableArray alloc] initWithCapacity:10];
    for (int y=0;y<3;y++){
        for (int x=0;x<3;x++){
            if (board[3*y+x]==[NSNumber numberWithInt:SquareState_Empty]){
                [moves addObject:[NSNumber numberWithInt:3*y+x]];
            }
        }
    }
    return [moves copy];
}

-(int)evaluateMiniMaxForBoard:board andPlayer:(PlayerTurn)player{
    if (player==PlayerTurn_X && [self isWinForScore:[self scoreForBoard:board andPlayer:player]]){
        return 10;
    }else if (player==PlayerTurn_O && [self isWinForScore:[self scoreForBoard:board andPlayer:player]]){
        return -10;
    }else{
        return 0;
    }
}

#pragma mark - NSCopying protocol

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy)
    {
        // Copy NSObject subclasses
        [copy setBoard:[self.board copyWithZone:zone]];
        
        // Set primitives
        [copy setGameState:self.gameState];
        [copy setPlayerTurn:self.playerTurn];
    }
    
    return copy;
}
@end
