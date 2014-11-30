//
//  PopupView.h
//  basra
//
//  Created by Alaa Awad on 8/24/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#define normalBadgeColor [UIColor colorWithRed:52.0/255 green:152.0/255 blue:219.0/255 alpha:1.0f]
#define darkBlueBadgeColor [UIColor colorWithRed:43.1/255 green:77.3/255 blue:72.2/255 alpha:1.0f]
#define yellowBadgeColor [UIColor colorWithRed:241.0/255 green:196.0/255 blue:15.0/255 alpha:1.0f]
#define cloudColor [UIColor colorWithRed:236.0/255 green:240.0/255 blue:241.0/255 alpha:1.0]

@interface PopupView : UIView
-(void) showView;
-(void) hideView;
-(void) showViewForever;
@property (nonatomic,strong) UILabel *label;
@end
