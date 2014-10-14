//
//  Game.h
//  TicTacToeAI
//
//  Created by Alaa Awad on 10/11/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject<NSCopying>

typedef enum
{
	SquareState_Empty,
	SquareState_X,
	SquareState_O
}
SquareState;


typedef enum
{
	PlayerTurn_X,
    PlayerTurn_O
}
PlayerTurn;


typedef enum
{
	GameState_Active,
    GameState_Ended
}
GameState;

@property (nonatomic,assign) PlayerTurn playerTurn;
@property (nonatomic,assign) GameState gameState;
@property (nonatomic,strong) NSMutableArray *board; // 3 x 3 array of SquareStates representing the board   

-(int)scoreForPlayer:(PlayerTurn)player;
-(BOOL)isWinForScore:(int)score;
//-(int)miniMaxForCurrentBoard:(NSArray *)currentBoard andCurrentPlayer:(PlayerTurn)player;
-(int)minimaxWithGameBoard:(NSArray *)board forPlayer:(PlayerTurn)player;
@end
