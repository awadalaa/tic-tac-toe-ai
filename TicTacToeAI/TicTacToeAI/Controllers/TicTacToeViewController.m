//
//  TicTacToeViewController.m
//  TicTacToeAI
//
//  Created by Alaa Awad on 10/11/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "TicTacToeViewController.h"

#import "Game.h"

#import "TicTacToeBoardView.h"
#import "XView.h"
#import "OView.h"


#define GridWidth self.view.frame.size.width/3
#define GridPadding 10.0f

@interface TicTacToeViewController ()
@property(nonatomic,strong)NSMutableArray *gridButtons;
@property(nonatomic,strong)TicTacToeBoardView *board;

@property(nonatomic,strong)Game *game;
@end

@implementation TicTacToeViewController


- (void)viewDidLoad
{

    [super viewDidLoad];
    self.game = [[Game alloc] init];
    [self initializeBoard];


}

-(void)initializeBoard{
    self.board = [[TicTacToeBoardView alloc] initWithFrame:CGRectMake(0,20.0f, self.view.frame.size.width, self.view.frame.size.height)];

    [self.view addSubview:self.board];
    
    [self initializeGridButtons];
}

-(void)initializeGridButtons{
    self.gridButtons = [[NSMutableArray alloc] initWithCapacity:9];
    
    for (int x=0;x<3;x++){
        for (int y=0;y<3;y++){
            UIButton *gridButton = [[UIButton alloc] initWithFrame:CGRectMake(x*GridWidth,y*GridWidth,GridWidth,GridWidth)];
            
            //XView *xView = [[XView alloc] initWithFrame:CGRectMake(GridPadding,GridPadding,GridWidth-2*GridPadding,GridWidth-2*GridPadding)];
            [gridButton addTarget:self
                       action:@selector(gridPressedForSquare:)
             forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.board addSubview:gridButton];
            self.gridButtons[x+y] = gridButton;
        }
    }

}

-(void)gridPressedForSquare:(id)sender{
    UIButton *gridButton = sender;
    if (self.game.playerTurn == PlayerTurn_X){
        XView *xView = [[XView alloc] initWithFrame:CGRectMake(GridPadding,GridPadding,GridWidth-2*GridPadding,GridWidth-2*GridPadding)];
        [gridButton addSubview:xView];
        self.game.board[0]=[NSNumber numberWithInt:SquareState_X];
    }else{
        OView *oView = [[OView alloc] initWithFrame:CGRectMake(GridPadding,GridPadding,GridWidth-2*GridPadding,GridWidth-2*GridPadding)];
        [gridButton addSubview:oView];
//        self.game.board[0]=[NSNumber numberWithInt:SquareState_O];
    }
    self.game.playerTurn = !self.game.playerTurn;
    NSLog(@"grid pressed");
}


@end
