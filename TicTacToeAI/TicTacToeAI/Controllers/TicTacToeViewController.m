//
//  TicTacToeViewController.m
//  TicTacToeAI
//
//  Created by Alaa Awad on 10/11/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "TicTacToeViewController.h"
#import "TicTacToeBoardView.h"
#import "XView.h"
#import "OView.h"

#define GridWidth self.view.frame.size.width/3
#define GridPadding 10.0f

@interface TicTacToeViewController ()
@property(nonatomic,strong)NSMutableArray *gridButtons;
@property(nonatomic,strong)TicTacToeBoardView *board;
@end

@implementation TicTacToeViewController


- (void)viewDidLoad
{

    [super viewDidLoad];
    [self initializeBoard];


}

-(void)initializeBoard{
    self.board = [[TicTacToeBoardView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.board];
    
    [self initializeGridButtons];
}

-(void)initializeGridButtons{
    self.gridButtons = [[NSMutableArray alloc] init];
    [self.gridButtons insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:0];
    [self.gridButtons insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:1];
    [self.gridButtons insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:2];
    
    for (int x=0;x<3;x++){
        for (int y=0;y<3;y++){
            UIButton *gridButton = [[UIButton alloc] initWithFrame:CGRectMake(x*GridWidth,y*GridWidth,GridWidth,GridWidth)];
            
            //XView *xView = [[XView alloc] initWithFrame:CGRectMake(GridPadding,GridPadding,GridWidth-2*GridPadding,GridWidth-2*GridPadding)];
            [gridButton addTarget:self
                       action:@selector(gridPressedForSquare:)
             forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.board addSubview:gridButton];
            self.gridButtons[x][y] = gridButton;
        }
    }

}

-(void)gridPressedForSquare:(id)sender{
    XView *xView = [[XView alloc] initWithFrame:CGRectMake(GridPadding,GridPadding,GridWidth-2*GridPadding,GridWidth-2*GridPadding)];
    UIButton *gridButton = sender;
    [gridButton addSubview:xView];
    NSLog(@"grid pressed");
}


@end
