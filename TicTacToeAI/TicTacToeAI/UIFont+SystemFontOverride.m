//
//  UIFont+SystemFontOverride.m
//  EMS-iOS
//
//  Created by Alaa Awad on 8/12/14.
//  Copyright (c) 2014 Technalaa. All rights reserved.
//

#import "UIFont+SystemFontOverride.h"

@implementation UIFont (SytemFontOverride)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
}

#pragma clang diagnostic pop

@end
