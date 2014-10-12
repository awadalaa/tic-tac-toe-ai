//
//  OView.m
//  TicTacToeAI
//
//  Created by Alaa Awad on 10/11/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "OView.h"

@implementation OView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [super setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Setting up the line width, type and color
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.5);
    
    CGContextAddEllipseInRect(context, rect);
    
    // Stroke and fill
    CGContextStrokePath(context);
    CGContextFillPath(context);
}

@end
