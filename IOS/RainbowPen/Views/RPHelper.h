//
//  RPHelper.h
//  RainbowPen
//
//  Created by Damien Romito on 18/10/14.
//  Copyright (c) 2014 RainbowPen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPHelper : NSObject

+ (UIColor *)colorWithPenColor:(PenColor)penColor;
+ (NSString *)colorStringWithPenColor:(PenColor)penColor;

+ (void)runAfterDelay:(CGFloat)delay block:(void (^)())block;

@end
