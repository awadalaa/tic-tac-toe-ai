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

@property (nonatomic,assign) int counts;

@property (nonatomic,strong) NSDictionary *level_scores;// key is level, value is scores array

@property (nonatomic,strong) NSMutableArray *board; // 3 x 3 array of SquareStates representing the board

-(int)scoreForPlayer:(PlayerTurn)player;
-(BOOL)isWinForScore:(int)score;
//-(int)miniMaxForCurrentBoard:(NSArray *)currentBoard andCurrentPlayer:(PlayerTurn)player;
-(int)minimaxRootWithGameBoard:(NSArray *)board  forPlayer:(PlayerTurn)player;
-(int)minimaxWithGameBoard:(NSArray *)board forPlayer:(PlayerTurn)player;
@end
