//
//  RPHelper.m
//  RainbowPen
//
//  Created by Damien Romito on 18/10/14.
//  Copyright (c) 2014 RainbowPen. All rights reserved.
//

#import "RPHelper.h"

@implementation RPHelper

+ (UIColor *)colorWithPenColor:(PenColor)penColor
{
    switch (penColor) {
        case PenColorBlue:
            return [UIColor blueColor];
            break;
        case PenColorRed:
            return [UIColor redColor];
            break;
        case PenColorCyan:
            return [UIColor cyanColor];
            break;
        case PenColorPurple:
            return [UIColor purpleColor];
            break;
        case PenColorYellow:
            return [UIColor yellowColor];
            break;
        case PenColorGreen:
            return [UIColor greenColor];
            break;
        case PenColorOrange:
            return [UIColor orangeColor];
            break;
        case PenColorRose:
            return RGBCOLOR(255, 97, 160);
            break;
        default:
            break;
    }
}

+ (NSString *)colorStringWithPenColor:(PenColor)penColor
{
    switch (penColor) {
        case PenColorBlue:
            return @"blue";
            break;
        case PenColorRed:
            return @"red";
            break;
        case PenColorCyan:
            return @"cyan";
            break;
        case PenColorPurple:
            return @"purple";
            break;
        case PenColorYellow:
            return @"yellow";
            break;
        case PenColorGreen:
            return @"green";
            break;
        case PenColorOrange:
            return @"orange";
            break;
        case PenColorRose:
            return @"pink";
            break;
        default:
            break;
    }
}

#pragma -mark Utils

+ (void) runAfterDelay:(CGFloat)delay block:(void (^)())block
{
    void (^block_)() = [block copy];
    [RPHelper performSelector:@selector(runBlock:) withObject:block_ afterDelay:delay];
    
}


+ (void) runBlock:(void (^)())block
{
    block();
}


@end
