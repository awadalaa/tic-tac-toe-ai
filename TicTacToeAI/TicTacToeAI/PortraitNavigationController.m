//
//  PortraitNavigationController.m
//  basra
//
//  Created by Alaa Awad on 4/13/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "PortraitNavigationController.h"

@implementation PortraitNavigationController

-(BOOL)shouldAutorotate
{
    return UIInterfaceOrientationMaskPortrait;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor colorWithRed:89/255.0f green:174/255.0f blue:235/255.0f alpha:1.0f];
    self.navigationBar.translucent = YES;
    NSMutableDictionary *textAttributes = [[NSMutableDictionary alloc] initWithDictionary:self.navigationBar.titleTextAttributes];
    [textAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = textAttributes;
}


@end
