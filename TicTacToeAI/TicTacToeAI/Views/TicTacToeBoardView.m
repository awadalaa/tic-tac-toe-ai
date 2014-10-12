//
//  TicTacToeBoardView.m
//  TicTacToeAI
//
//  Created by Alaa Awad on 10/11/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "TicTacToeBoardView.h"

@implementation TicTacToeBoardView

- (void)initObject {
    [super setBackgroundColor:[UIColor clearColor]];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initObject];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{    
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Setting up the line width, type and color
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.5);
    
    // Horizontal Lines
    CGContextMoveToPoint(context, 0, rect.size.width/3);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.width/3);
    
    CGContextMoveToPoint(context, 0, 2*rect.size.width/3);
    CGContextAddLineToPoint(context, rect.size.width, 2*rect.size.width/3);
    
    // Vertical Lines
    CGContextMoveToPoint(context, rect.size.width/3, 0);
    CGContextAddLineToPoint(context, rect.size.width/3, rect.size.width);
    
    CGContextMoveToPoint(context, 2*rect.size.width/3, 0);
    CGContextAddLineToPoint(context, 2*rect.size.width/3, rect.size.width);
    
    // Stroke and fill
    CGContextStrokePath(context);
    CGContextFillPath(context);
}



@end
