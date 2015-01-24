//
//  ColoringGameView.h
//  RainbowPen
//
//  Created by Damien Romito on 18/10/14.
//  Copyright (c) 2014 RainbowPen. All rights reserved.
//

#import "GameView.h"

@interface ColoringGameView : UIView

@property (nonatomic, weak) id delegate;
@property (nonatomic) PenColor currentColor;

- (instancetype)initWithIndex:(NSUInteger)index inView:(UIView*)container;

@end


@protocol ColoringGameDelegate <NSObject>

- (void)coloringGameMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)coloringGameBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)coloringGameEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)successGame;
- (void)outOfView;
@end