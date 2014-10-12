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

@interface TicTacToeViewController ()

@end

@implementation TicTacToeViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    TicTacToeBoardView *board = [[TicTacToeBoardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:board];
    
    XView *xView = [[XView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/3, self.view.frame.size.width/3, self.view.frame.size.width/3)];
    [self.view addSubview:xView];
    
    OView *oView = [[OView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, 0, self.view.frame.size.width/3, self.view.frame.size.width/3)];
    [self.view addSubview:oView];
    
}


@end
