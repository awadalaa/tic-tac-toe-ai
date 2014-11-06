//
//  GameAI.h
//  TicTacToeAI
//
//  Created by Alaa Awad on 11/5/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface GameAI : NSObject

@property (nonatomic,strong) Game *game;


- (id)initWithGame:(Game *) game;
-(BOOL)isGameOver:(NSArray *)board;
-(BOOL)isWinForScore:(int)score;
-(int)scoreForPlayer:(PlayerTurn)player;
-(int)minimaxRootWithGameBoard:(NSArray *)board  forPlayer:(PlayerTurn)player;
-(int)minimaxWithGameBoard:(NSArray *)board forPlayer:(PlayerTurn)player;
@end
