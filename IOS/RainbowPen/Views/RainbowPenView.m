//
//  RainbowPenView.m
//  RainbowPen
//
//  Created by Damien Romito on 18/10/14.
//  Copyright (c) 2014 RainbowPen. All rights reserved.
//

#import "RainbowPenView.h"
#import <QuartzCore/QuartzCore.h>

#import "RFduinoManagerDelegate.h"
#import "RFduinoManager.h"
#import "RFduino.h"
#import "UIImage+overlay.h"

//@class RFduinoManager;
//@class RFduino;
//

@interface RainbowPenView()<RFduinoDelegate, RFduinoManagerDelegate, RFduinoDelegate>
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) RFduinoManager *rfduinoManager;
@property (strong, nonatomic) RFduino *rfduino;
@property (strong, nonatomic) UIActivityIndicatorView *loadingView;
@property (strong, nonatomic) UIImageView *penView;

//@property (nonatomic) BOOL penIsConnected;
@end

@implementation RainbowPenView


- (instancetype)initAtPosition:(CGPoint)position
{
    self = [super initWithFrame:CGRectMake(position.x, position.y, RAINBOW_PEN_WIDTH, RAINBOW_PEN_HEIGHT)];
    if (self) {
        self.rfduinoManager = [RFduinoManager sharedRFduinoManager];
        self.rfduinoManager.delegate = self;
        
      //  self.backgroundColor = RGBCOLOR(200,200,200);
        
        self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.loadingView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.loadingView startAnimating];
        [self addSubview:self.loadingView];
        
//        self.label = [[UILabel alloc] initWithFrame:self.loadingView.frame];
//        [self addSubview:self.label];

        self.status = PenStatusLoading;
        
        self.penView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pen"]];
        self.penView.frame = CGRectMake(0, 0, RAINBOW_PEN_WIDTH, RAINBOW_PEN_HEIGHT);
        [self addSubview:self.penView];
    }
    return self;
}

- (void)setStatus:(PenStatus)status
{
    _status = status;
    switch (status) {
        case PenStatusUnavailable:
            self.penView.image = [self.penView.image imageWithColor:[UIColor blackColor] ];
            self.penView.alpha = .5;
            break;
        case PenStatusConnected:
            self.penView.alpha = 1.;
            break;
        case PenStatusLoading:
            self.penView.image = [self.penView.image imageWithColor:[UIColor blackColor] ];
            self.penView.alpha = .5;
            break;
        default:
            break;
    }
  //  self.label.text = string;
}


- (void)setPenColor:(PenColor)penColor
{
    _penColor = penColor;
    if ([self.delegate respondsToSelector:@selector(rainbowPenColorChanged:)]) {
        [self.delegate rainbowPenColorChanged:penColor];
    }
    self.penView.image = [self.penView.image imageWithColor:[RPHelper colorWithPenColor:penColor] ];

    NSLog(@" PEN COLOR %i", penColor);

}

#pragma mark - RfduinoDelegate methods


- (void)didReceive:(NSData *)data
{
    
    NSInteger value = dataInt(data);
    if (value > 0 && value <= 8) {
        self.penColor = dataInt(data);
    }
    
    NSLog(@" dataInt(data) %i", value);
    //self.penColor = PenColorBlue;
}


#pragma mark - RfduinoDiscoveryDelegate methods

- (void)didDiscoverRFduino:(RFduino *)rfduino
{
        NSLog(@"didDiscoverRFduino");
    self.penColor = 8;
    //    if (! editingRow) {
    //        NSLog(@"reloadData");
    //        [self.tableView reloadData];
    //    }
}

- (void)didUpdateDiscoveredRFduino:(RFduino *)rfduino
{


    for (RFduino *rfduino in self.rfduinoManager.rfduinos ) {

        if ([rfduino.name isEqualToString:@"RFduino"]) {
             [self.rfduinoManager connectRFduino:rfduino];
        }
    }
    //    if (! editingRow) {
    //        [self.tableView reloadData];
    //    }
}

- (void)didConnectRFduino:(RFduino *)rfduino
{
    NSLog(@"didConnectRFduino");
    self.status = PenStatusConnected;
    [self.loadingView stopAnimating];
    [self.rfduinoManager stopScan];
    NSLog(@"rfduino %@", self.rfduino);


    //
    //    loadService = false;
}

- (void)didLoadServiceRFduino:(RFduino *)rfduino
{
    self.rfduino = rfduino;
    [self.rfduino setDelegate:self];

    //    AppViewController *viewController = [[AppViewController alloc] init];
    //    viewController.rfduino = rfduino;
    //
    //    loadService = true;
    //    [[self navigationController] pushViewController:viewController animated:YES];
}

- (void)didDisconnectRFduino:(RFduino *)rfduino
{
    NSLog(@"didDisconnectRFduino");
    //
    //    if (loadService) {
    //        [[self navigationController] popViewControllerAnimated:YES];
    //    }
    //
    [self.loadingView startAnimating];

    [self.rfduinoManager startScan];
    //    [self.tableView reloadData];
}


@end
