//
//  RainbowPenView.h
//  RainbowPen
//
//  Created by Damien Romito on 18/10/14.
//  Copyright (c) 2014 RainbowPen. All rights reserved.
//


typedef NS_ENUM(NSUInteger, PenStatus) {
    PenStatusUnavailable = 0,
    PenStatusLoading = 1,
    PenStatusConnected = 2,
    
};

static CGFloat const RAINBOW_PEN_WIDTH =  100.;
static CGFloat const RAINBOW_PEN_HEIGHT =  100.;
static NSInteger const ERROR_PLAYLIST_EMPTY  =  9998;

@interface RainbowPenView : UIView

@property (nonatomic) PenStatus status;
@property (nonatomic) PenColor penColor;
@property (nonatomic, weak) id delegate;

- (instancetype)initAtPosition:(CGPoint)position;

@end

@protocol RainbowPenDelegate <NSObject>

- (void)rainbowPenColorChanged:(PenColor)penColor;

@end
