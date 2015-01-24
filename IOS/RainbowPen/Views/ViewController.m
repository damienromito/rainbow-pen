//
//  ViewController.m
//  RainbowPen
//
//  Created by Damien Romito on 18/10/14.
//  Copyright (c) 2014 RainbowPen. All rights reserved.
//

#import "ViewController.h"
#import "RainbowPenView.h"
#import "ACEDrawingView.h"
#import "ColoringGameView.h"


@interface ViewController ()<RainbowPenDelegate, ColoringGameDelegate>
@property (nonatomic, strong) ACEDrawingView *drawingView;
@property (nonatomic, strong) ColoringGameView *coloringView;
@property (nonatomic, strong) UILabel *successLabel;
@property (nonatomic, strong) UILabel *outLabel;

@property (nonatomic, strong) UIImageView *successView;
@property (nonatomic, strong) UIView *gameContainer;
@property (nonatomic) NSInteger gameCount;
@property (nonatomic) BOOL isAnimating;
@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    
    self.gameContainer = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.gameContainer];
    
    RainbowPenView *penView = [[RainbowPenView alloc] initAtPosition:CGPointMake(self.view.frame.size.width - RAINBOW_PEN_WIDTH, self.view.frame.size.height - RAINBOW_PEN_WIDTH)];
    penView.delegate = self;
    [self.view addSubview:penView];
    
    self.successView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"macaron"]];
    CGRect frame = self.successView.frame;
    frame.origin.x = self.view.frame.size.width /2 - frame.size.width/2;
    frame.origin.y = self.view.frame.size.height /2 - frame.size.height/2;
    self.successView.frame = frame;
    self.successLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.successView.frame.size.width, self.successView.frame.size.height)];
    self.successLabel.textAlignment = NSTextAlignmentCenter;
    self.successLabel.textColor = [UIColor blackColor];
    self.successLabel.font =[UIFont fontWithName:@"MarkerFelt-Wide" size:30];
    self.successLabel.text = @"Great!";
    [self.successView addSubview:self.successLabel];
    
    [self.view addSubview:self.successView];


    [self newGame];
    //self.view.userInteractionEnabled = NO;
  
    self.outLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,self.view.frame.size.height - 100, self.view.frame.size.width, 100)];
    self.outLabel.textColor = [UIColor redColor];
    self.outLabel.font =[UIFont fontWithName:@"MarkerFelt-Wide" size:40];
    self.outLabel.text = @"NE DEPASSE PAS !";
    self.outLabel.hidden = YES;
    [self.view addSubview:self.outLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)rainbowPenColorChanged:(PenColor)penColor
{
    [self.drawingView setLineColor:[RPHelper colorWithPenColor:penColor]];
    [self.coloringView setCurrentColor:penColor];
}
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//   
//    
//   // [super touchesBegan:touches withEvent:event];
//
//    [self.drawingView touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//   // [self touchesMoved:touches withEvent:event];
//    NSLog(@"moooveSUPER");
//
//    [self.drawingView touchesMoved:touches withEvent:event];
//}

- (void)coloringGameMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self.drawingView touchesMoved:touches withEvent:event];

}
- (void)coloringGameBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.drawingView touchesBegan:touches withEvent:event];
    
}

- (void)coloringGameEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.drawingView touchesEnded:touches withEvent:event];
    
}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"ended");
//
//    //[super touchesEnded:touches withEvent:event];
//    [self.drawingView touchesEnded:touches withEvent:event];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)newGame
{
    if (self.gameCount == 0) {
        
        self.drawingView = [[ACEDrawingView alloc] initWithFrame:self.view.bounds];

        [self.gameContainer addSubview:self.drawingView];
        
        
        self.coloringView = [[ColoringGameView alloc] initWithIndex:0 inView:self.view];
        self.coloringView.delegate = self;

        
        [self.gameContainer addSubview:self.coloringView];
        
        [self.coloringView setTransform:CGAffineTransformMakeTranslation(0, self.view.frame.size.height)];
        [self.drawingView setTransform:CGAffineTransformMakeTranslation(0, self.view.frame.size.height)];

        self.successLabel.text = @"Colors Learning!";
        [self animateView:self.successView];

        [UIView animateKeyframesWithDuration:.3 delay:2 options:0 animations:^{
            [self.coloringView setTransform:CGAffineTransformMakeTranslation(0, 0)];
            [self.drawingView setTransform:CGAffineTransformMakeTranslation(0, 0)];
        } completion:^(BOOL finished) {

        }];

    }else
    {
        self.drawingView = [[ACEDrawingView alloc] initWithFrame:self.view.bounds];

        [self.gameContainer addSubview:self.drawingView];

        

        //self.drawingView.delegate = self;
        
        self.successLabel.text = @"Free Painting!";
        [self animateView:self.successView];
        
        [self.drawingView setTransform:CGAffineTransformMakeTranslation(0, self.view.frame.size.height)];

        [UIView animateKeyframesWithDuration:.3 delay:2 options:0 animations:^{
            [self.drawingView setTransform:CGAffineTransformMakeTranslation(0, 0)];
        } completion:^(BOOL finished) {
        }];
        

    }
    self.gameCount ++;

}
- (void)successGame
{
    
    [RPHelper runAfterDelay:3 block:^{
        self.successLabel.text = @"Congrats!";
        
        [self animateView:self.successView];
        
        
        [UIView animateWithDuration:.3 delay:2 options:0 animations:^{
            [self.coloringView setTransform:CGAffineTransformMakeTranslation(0, self.view.frame.size.height)];
            [self.drawingView setTransform:CGAffineTransformMakeTranslation(0, self.view.frame.size.height)];
        } completion:^(BOOL finished) {
            [self.drawingView removeFromSuperview];
            [self.coloringView removeFromSuperview];
            [self newGame];
            
            
            
        }];
    }];

}

- (void)animateView:(UIView *)view
{
    view.alpha = 0.;
    view.hidden = NO;
    [UIView animateWithDuration:.3 animations:^{
        view.alpha = 1.;
        [view setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 delay:1 options:0 animations:^{
            view.alpha = 0.;
        } completion:^(BOOL finished) {
            [view setTransform:CGAffineTransformMakeScale(1., 1.)];
            view.hidden = YES;
        }];
    }];
}



- (void)outOfView
{
    self.outLabel.hidden = NO;
    UIView *view = self.outLabel;
    if (!self.isAnimating) {
        self.isAnimating = YES;
        [UIView animateWithDuration:.1 animations:^{
            [view setTransform:CGAffineTransformMakeTranslation(0, 0)];
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:.1 animations:^{
                [view setTransform:CGAffineTransformMakeTranslation(0, 10)];
                
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:.1 animations:^{
                    [view setTransform:CGAffineTransformMakeTranslation(0, 0)];
                    
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:.1 animations:^{
                        [view setTransform:CGAffineTransformMakeTranslation(0, 10)];
                        
                    }completion:^(BOOL finished) {
                            self.outLabel.hidden = YES;
                        self.isAnimating = NO;
                    }];
                }];
            }];
        }];
    }
    
}
@end
