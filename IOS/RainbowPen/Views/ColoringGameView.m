//
//  ColoringGameView.m
//  RainbowPen
//
//  Created by Damien Romito on 18/10/14.
//  Copyright (c) 2014 RainbowPen. All rights reserved.
//

#import "ColoringGameView.h"
#import "OBShapedButton.h"

@interface ColoringGameView()<OFShapedButtonDelegate>
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) UIView *infosView;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic) NSInteger colorCount;

@end
@implementation ColoringGameView



- (instancetype)initWithIndex:(NSUInteger)index inView:(UIView*)container
{
    //INFOS
    
    
    NSString *filePathString = [[NSBundle mainBundle] pathForResource:@"Colorings" ofType:@"plist"];
    NSArray *coloringsArray = [NSArray arrayWithContentsOfFile:filePathString];
    NSDictionary *coloring = [coloringsArray objectAtIndex:index];
    UIImage *modelImage = [UIImage imageNamed:[coloring valueForKey:@"image"] ];
   
    self = [super initWithFrame:container.frame];
    
   // self.backgroundColor = [UIColor whiteColor];

    self.infosView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:self.infosView];
    
    self.colors = [coloring valueForKey:@"colors"];
    self.colorCount = self.colors.count;
    if (self) {
        
        int index = 0;
        for (NSDictionary *image in self.colors ) {
            
            UIImage *colorImage = [UIImage imageNamed:[image valueForKey:@"image"]];
            OBShapedButton *view = [[OBShapedButton alloc] initWithFrame:self.frame];
            [view setImage:colorImage forState:UIControlStateNormal];
            view.alpha = .011f;
            view.delegate = self;
            [view addTarget:self action:@selector(actionTouch:) forControlEvents:UIControlEventTouchDown];
            view.imageView.contentMode = UIViewContentModeScaleAspectFit;
            view.tag = index + 1;
            [self addSubview:view];

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + index * 50, self.frame.size.width, 50)];
            NSInteger penColor = [[image valueForKey:@"color"] intValue];
            NSString *colorString = [RPHelper colorStringWithPenColor:  penColor ];
            label.text = [NSString stringWithFormat:@"Paint %@ in %@", [image valueForKey:@"object"], colorString ];
            label.font =[UIFont fontWithName:@"MarkerFelt-Wide" size:30];
            label.alpha = 0.;
            label.tag = index + 1;
            label.textColor = [UIColor blackColor];
            [self.infosView addSubview:label];
            [UIView animateWithDuration:.3 delay:.3*index options:0 animations:^{
                label.alpha = 0.95;
                [label setTransform:CGAffineTransformMakeTranslation(0, 10)];
            } completion:^(BOOL finished) {
                
            }];
            
            
            index ++;
        }
        
        
        UIImageView *emptyImage = [[UIImageView alloc] initWithImage:modelImage];
        emptyImage.userInteractionEnabled = NO;
        emptyImage.frame = self.frame;
        emptyImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:emptyImage];
        
        [self.infosView bringSubviewToFront:self];
        
    }
    return self;
}

//- (void)createExplanationfor:(NSString *)object inColor:(PenColor)penColor
//{
//}

- (void)actionTouch:(OBShapedButton*)button
{
    
    NSLog(@"Touch button %i", button.tag);
}


- (void)actionTouchOut:(OBShapedButton*)button
{
    
    NSLog(@"Out %i", button.tag);
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(coloringGameBegan:withEvent:)]) {
        [self.delegate coloringGameBegan:touches withEvent:event];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(coloringGameMoved:withEvent:)]) {
        [self.delegate coloringGameMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if ([self.delegate respondsToSelector:@selector(coloringGameEnded:withEvent:)]) {
        [self.delegate coloringGameEnded:touches withEvent:event];
    }
}

#pragma -mark ShapeButton Delegate

- (void)shapedButtonOutOfArea
{
    NSLog(@"DONT");
    [self.delegate outOfView];
}

- (void)shapedButtonTagColoringIn:(NSInteger)tag
{
    NSDictionary *coloring = [self.colors objectAtIndex:tag - 1];
    NSLog(@"CURREN TCOOT %@", [RPHelper colorStringWithPenColor:self.currentColor]);
    NSLog(@"ZONE %@", [RPHelper colorStringWithPenColor:[[coloring valueForKey:@"color"] intValue] ]);
    PenColor objectColor = [[coloring valueForKey:@"color"] intValue];
    
    if (objectColor == self.currentColor) {
        NSLog(@"write color");
        if ([self.infosView viewWithTag:tag].alpha < 1.) {
            UILabel *label = (UILabel*)[self.infosView viewWithTag:tag];
            label.textColor = [RPHelper colorWithPenColor:objectColor];
            label.alpha = 1.;
            self.colorCount --;
            
            if (!self.colorCount) {
                [self.delegate successGame];
            }
        }
        
        
    }else
    {
        NSLog(@"WRONG COLOR");
        [self wizzAnimation:[self.infosView viewWithTag:tag]];
    }
}

- (void)wizzAnimation:(UIView *)view
{
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
                        self.isAnimating = NO;
                    }];
                }];
            }];
        }];
    }
   
}

@end
