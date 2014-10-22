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
#import "SquareButton.h"

#define SquareWidth self.view.frame.size.width/3.0f
#define SquarePadding self.view.frame.size.width/30.0f

@interface TicTacToeViewController (){
    UISegmentedControl *segmentedControl;
    UILabel *winnerlabel;
    UIActivityIndicatorView *spinner;
}

@property(nonatomic,strong)NSMutableArray *squareButtons;
@property(nonatomic,strong)TicTacToeBoardView *uiboard;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;


@property(nonatomic,strong)Game *game;
@end

@implementation TicTacToeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.game = [[Game alloc] init];
    [self initializeBoard];
    [self configureSegmentedControl];
    winnerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-40.0f-44.0f/*toolbarheight*/,self.view.frame.size.width,40.0f)];
    winnerlabel.textAlignment = NSTextAlignmentCenter;
    winnerlabel.font = [UIFont fontWithName:@"Helvetica" size:30.0f];
    [self.view addSubview:winnerlabel];
    [self loadSpinner];
    if (segmentedControl.selectedSegmentIndex==0 && self.game.playerTurn==PlayerTurn_X){
        [self performAI_Algorithm];
    }
    
}

- (void) performAI_Algorithm
{
    [self.activityIndicator startAnimating]; //Or whatever UI Change you need to make
    [self performSelector: @selector(AI_PlayMove)
               withObject: nil
               afterDelay: 0];
    return;
}

-(void)loadSpinner {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [segmentedControl removeFromSuperview];
}




#pragma mark - Initialization
-(void)initializeBoard{
    self.uiboard = [[TicTacToeBoardView alloc] initWithFrame:CGRectMake(0,30, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:self.uiboard];
    
    [self initializeSquareButtons];
}

-(void)initializeSquareButtons{
    /*
     * Add 9 square buttons to the board. On Touch Up it will call selector squarePressedForSquare:
     * we can get the squareId from there.
     */
    
    self.squareButtons = [[NSMutableArray alloc] initWithCapacity:9];
    
    for (int y=0;y<3;y++){
        for (int x=0;x<3;x++){
            SquareButton *squareButton = [[SquareButton alloc] initWithFrame:CGRectMake(x*SquareWidth,y*SquareWidth,SquareWidth,SquareWidth)];
            squareButton.squareId = x+3*y;
            [squareButton addTarget:self
                       action:@selector(squarePressedForSquareButton:)
             forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.uiboard addSubview:squareButton];
            self.squareButtons[x+3*y] = squareButton;
        }
    }

}


#pragma mark - UISegmentControl
-(void)configureSegmentedControl{
    // Add a UIToolbar to bottom
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    [self.view addSubview:toolbar];
    
    // Add a UISegmentControl
    NSArray *segItemsArray = [NSArray arrayWithObjects: @"1 Player", @"2 Player",@"Reset", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:segItemsArray];
    
    segmentedControl.frame = CGRectMake(0, 0, 200, 30);
    segmentedControl.selectedSegmentIndex = 1;
    [segmentedControl addTarget:self action:@selector(changeSegment:)
               forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segmentedControlButtonItem = [[UIBarButtonItem alloc] initWithCustomView:(UIView *)segmentedControl];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *barArray = [NSArray arrayWithObjects: flexibleSpace, segmentedControlButtonItem, flexibleSpace, nil];
    [toolbar setItems:barArray];
}


-(void)changeSegment:(id)sender{
    NSLog(@"%ld",(long)segmentedControl.selectedSegmentIndex);
    long index = (long)segmentedControl.selectedSegmentIndex;
    
    if (index==0 && self.game.playerTurn==PlayerTurn_X){
        // if changed to AI in the middle of X move, AI should play
        [self performAI_Algorithm];
    }
    
    if (index==1 && self.game.playerTurn==PlayerTurn_X){
        //int choice = [self.game minimaxWithGameState:self.game.board forPlayer:self.game.playerTurn];
        //[self squareIdSelected:choice];
    }
    
    if (index==2){
        [self resetGame];
        
        // after reset if 0 selected, AI should move
        if (segmentedControl.selectedSegmentIndex==0 && self.game.playerTurn==PlayerTurn_X){
            [self performAI_Algorithm];
        }

    }
}



#pragma mark - Square Pressed Logic

-(void)squarePressedForSquareButton:(id)squareBtn{
    if (self.game.playerTurn==PlayerTurn_X && segmentedControl.selectedSegmentIndex==0 /* AI turned on */){
        return; // not your turn. AI is player X
    }
    
    SquareButton *squareButton = squareBtn;
    NSLog(@"square pressed %d",squareButton.squareId);
    [self squareIdSelected:squareButton.squareId];
    
    if (self.game.gameState != GameState_Ended){
        if (self.game.playerTurn==PlayerTurn_X && segmentedControl.selectedSegmentIndex==0 /* AI turned on */){
            [self performAI_Algorithm];
        }
    }
    
}


-(void)squareIdSelected:(int)squareId{
    if (self.game.playerTurn == PlayerTurn_X){
        XView *xView = [[XView alloc] initWithFrame:CGRectMake(SquarePadding,SquarePadding,SquareWidth-2*SquarePadding,SquareWidth-2*SquarePadding)];
        [self.squareButtons[squareId] addSubview:xView];
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:[self.game.board mutableCopy]];
//        tempArr = [self.game.board mutableCopy];
        tempArr[squareId] =[NSNumber numberWithInt:SquareState_X];
        self.game.board = tempArr;
    }else{
        OView *oView = [[OView alloc] initWithFrame:CGRectMake(SquarePadding,SquarePadding,SquareWidth-2*SquarePadding,SquareWidth-2*SquarePadding)];
        [self.squareButtons[squareId] addSubview:oView];
        self.game.board[squareId] = [NSNumber numberWithInt:SquareState_O];
    }
    
    [self evaluateBoardForWins];
    [self togglePlayerTurn];
}



-(void)togglePlayerTurn{
    self.game.playerTurn = !self.game.playerTurn;
}

-(void)AI_PlayMove{
    int choice = [self.game minimaxRootWithGameBoard:self.game.board forPlayer:self.game.playerTurn];
    // after this step, perfect choice will be calculated
    
    [self.activityIndicator stopAnimating];
    [self squareIdSelected:choice];

}




-(void)evaluateBoardForWins{
    int score = [self.game scoreForPlayer:self.game.playerTurn];
    NSLog(@"score of game is %d",score);    
    if ([self.game isWinForScore:score]){
        NSLog(@"winner!!!");
        self.game.gameState = GameState_Ended;
        [self winnerIsPlayer:self.game.playerTurn];
    }else{
        NSLog(@"no win");
    }
}

-(void)resetGame{
    for (int i=0; i<9;i++)
        self.game.board[i] = [NSNumber numberWithInt:SquareState_Empty];
    
    [[self.uiboard subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self initializeSquareButtons];
    self.game.playerTurn = PlayerTurn_X;
    segmentedControl.selectedSegmentIndex=1;
    winnerlabel.text = @"";
    self.game.gameState = GameState_Active;
}


-(void)winnerIsPlayer:(PlayerTurn)player{
    // disable other squares show winner
    for (UIButton *squareButton in [self.uiboard subviews]){
        [squareButton setEnabled:NO];
    }
   
    if (player==PlayerTurn_X){
        winnerlabel.text = @"X wins!";
    }else{
        winnerlabel.text = @"O wins!";
    }
}


@end
