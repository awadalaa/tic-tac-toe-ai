//
//  GameAI.m
//  TicTacToeAI
//
//  Created by Alaa Awad on 11/5/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "GameAI.h"

@implementation GameAI


- (id)initWithGame:(Game *) game
{
    if ((self = [super init]))
    {
        // initialize 3x3 board with empty states
        self.game = game;
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
            if (self.game.board[3*y+x]==[NSNumber numberWithInt:playerSquare])
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


-(BOOL) isItFirstMoveForBoard:(NSArray *)board{
    BOOL empty=YES;
    for (int y=0;y<3;y++){
        for (int x=0;x<3;x++){
            if (board[x+3*y] != [NSNumber numberWithInt: SquareState_Empty]) empty=NO;
        }
    }
    return empty;
}


#pragma mark - minimax algorithm


-(int)minimaxWithGameBoard:(NSArray *)board  forPlayer:(PlayerTurn)player{
    if ([self isWinForScore:[self scoreForBoard:board andPlayer:player]] || [self isWinForScore:[self scoreForBoard:board andPlayer:!player]] || [self isGameOver:board]){
        return [self evaluateMiniMaxForBoard:board andPlayer:player];
    }
    
    int score=-10;
    NSArray *moves = [self movesAvailableInBoard:board];
    id enumerator = [moves objectEnumerator];
    id m;
    while (m = [enumerator nextObject]) {
        int move = [m intValue];
        NSMutableArray *newboard = [board mutableCopy];
        newboard[move]=(player==PlayerTurn_X)?[NSNumber numberWithInt:SquareState_X]:[NSNumber numberWithInt:SquareState_O];
        int sc = -[self minimaxWithGameBoard:newboard forPlayer:!player];
        if (sc > score)
            score = sc;
    }
    return score;
}


-(int)minimaxRootWithGameBoard:(NSArray *)board  forPlayer:(PlayerTurn)player{
    
    if ([self isItFirstMoveForBoard:board]){
        // if it is first move of the game just pick a random square. otherwise it will always choose the top left
        return arc4random() % 9; // random between 0 and 9
    }
    
    id bestmove = nil;
    int score=-10;
    NSArray *moves = [self movesAvailableInBoard:board];
    id enumerator = [moves objectEnumerator];
    id m;
    while (m = [enumerator nextObject]) {
        int move = [m intValue];
        NSMutableArray *newboard = [board mutableCopy];
        newboard[move]=(player==PlayerTurn_X)?[NSNumber numberWithInt:SquareState_X]:[NSNumber numberWithInt:SquareState_O];
        
        int sc = -[self minimaxWithGameBoard:newboard forPlayer:!player];
        if (sc > score){
            score = sc;
            bestmove=m;
        }
    }
    return [bestmove intValue];
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
    if (player==PlayerTurn_X){
        if ([self isWinForScore:[self scoreForBoard:board andPlayer:PlayerTurn_X]]){
            return 10;
        }else if ([self isWinForScore:[self scoreForBoard:board andPlayer:PlayerTurn_O]]){
            return -10;
        }else{
            return 0;
        }
    }else{
        if ([self isWinForScore:[self scoreForBoard:board andPlayer:PlayerTurn_O]]){
            return 10;
        }else if ([self isWinForScore:[self scoreForBoard:board andPlayer:PlayerTurn_X]]){
            return -10;
        }else{
            return 0;
        }
    }

}


-(BOOL)isGameOver:(NSArray *)board{
    for (int i = 0; i<9; i++) {
        if (board[i]==[NSNumber numberWithInt:SquareState_Empty])
            return NO;
    }
    return YES;
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
