//
//  Game.m
//  TicTacToeAI
//
//  Created by Alaa Awad on 10/11/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "Game.h"
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
