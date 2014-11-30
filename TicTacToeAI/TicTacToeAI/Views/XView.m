//
//  XView.m
//  TicTacToeAI
//
//  Created by Alaa Awad on 10/11/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "XView.h"

@implementation XView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [super setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //draw red circle
    
    // Setting up the line width, type and color
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.5);
    
    CGContextAddEllipseInRect(context, rect);
    
    // Stroke and fill
    CGContextFillPath(context);
    
    
    
    
    // Setting up the line width, type and color
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 2.5);
    
    // Horizontal Lines
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.width);
    
    CGContextMoveToPoint(context, rect.size.width,0);
    CGContextAddLineToPoint(context, 0, rect.size.width);
    
    // Stroke and fill
    CGContextStrokePath(context);
    CGContextFillPath(context);
    
}


@end
