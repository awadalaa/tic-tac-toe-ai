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
		self.board = [[NSMutableArray alloc] init];
        for (int x = 0;x<3;x++){
            for (int y=0;y<3;y++){
                self.board[x][y] = SquareState_Empty;
            }
        }
	}
	return self;
}


@end
