//
//  PopupView.m
//  basra
//
//  Created by Alaa Awad on 8/24/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "PopupView.h"
#define IS_PAD  (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)

@implementation PopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.0f;
        self.layer.cornerRadius = 15.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = normalBadgeColor;
        self.label  = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
        self.label.textColor = [UIColor whiteColor];
        self.label.font =  [UIFont fontWithName:@"Helvetica" size:IS_PAD?50:30];        self.label.numberOfLines = 0;
        self.label.lineBreakMode = NSLineBreakByWordWrapping;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.label setCenter:self.center];
        [self addSubview:self.label];
    }
    return self;
}


-(void) showView{
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.5f]; // add the value you want
    self.alpha = 1.0f;
    [UIView commitAnimations];
    
    // hide again
    NSTimeInterval timeInterval = 2.0f; // how long your view will last before hiding
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(hideView) userInfo:nil repeats:NO];
}



-(void) showViewForever{
    
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.5f]; // add the value you want
    self.alpha = 1.0f;
    [UIView commitAnimations];
    
}


-(void) hideView {
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:0.5]; // add the value you want
    self.alpha = 0.0f;
    [UIView commitAnimations];
}

@end
