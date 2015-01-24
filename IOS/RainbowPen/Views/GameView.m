//
//  GameView.m
//  RainbowPen
//
//  Created by Damien Romito on 19/10/14.
//  Copyright (c) 2014 RainbowPen. All rights reserved.
//

#import "GameView.h"


@interface GameView()
@property (nonatomic, strong) UILabel *successLabel;
@property (nonatomic, strong) UILabel *failLabel;
@end
@implementation GameView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CGSize size = [[UIApplication sharedApplication] keyWindow].frame.size;

        self.successLabel = [[UILabel alloc] initWithFrame:self.frame];
        self.successLabel.textAlignment = NSTextAlignmentCenter;
        self.successLabel.textColor = [UIColor greenColor];
        self.successLabel.text = @"Great!";
        [self addSubview:self.successLabel];
        
        self.failLabel = [[UILabel alloc] initWithFrame:self.frame];
        self.failLabel.textAlignment = NSTextAlignmentCenter;
        self.failLabel.textColor = [UIColor redColor];
        self.failLabel.text = @"NOOOO!";
        [self addSubview:self.failLabel];
        
        
    }
    return self;
}

- (void)success
{
     [self animateLabel:self.successLabel];
}

- (void)failure
{
    [self animateLabel:self.failLabel];
}

- (void)animateLabel:(UILabel *)label
{
    label.alpha = 0.;
    label.hidden = NO;
    [UIView animateWithDuration:.3 animations:^{
        label.alpha = 1.;
        [label setTransform:CGAffineTransformMakeScale(2., 2.)];

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 delay:.5 options:0 animations:^{
            label.alpha = 0.;
        } completion:^(BOOL finished) {
            [label setTransform:CGAffineTransformMakeScale(1., 1.)];
             label.hidden = YES;
        }];
    }];
}

@end
