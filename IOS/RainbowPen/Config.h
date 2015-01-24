//
//  Config.h
//  RainbowPen
//
//  Created by Damien Romito on 18/10/14.
//  Copyright (c) 2014 RainbowPen. All rights reserved.
//

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f \
blue:(b)/255.0f alpha:1.0f]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

typedef NS_ENUM(NSUInteger, PenColor) {
    PenColorRose = 1,
    PenColorPurple = 2,
    PenColorBlue = 3,
    PenColorCyan = 4,
    PenColorGreen = 5,
    PenColorYellow = 6,
    PenColorOrange = 7,
    PenColorRed = 8,
    
};
