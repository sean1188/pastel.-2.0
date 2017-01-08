//
//  GameController.m
//  pastel.
//
//  Created by Seannn! on 5/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import "GameController.h"

@interface GameController ()

@end

@implementation GameController
NSTimer *timer;
NSTimer *Countdowntimer;
float timeInt;
- (void)viewDidLoad {
    [super viewDidLoad];
    //  additional setup for animation after loading the view.
    _dotsView.layer.cornerRadius = 15.0f;
    _dotsView.layer.shadowRadius = 3; _dotsView.layer.shadowOpacity = 0.3; _dotsView.layer.shadowOffset = CGSizeMake(1, 3);
    _dotsView.transform = CGAffineTransformMakeScale(0, 0); _dotsView.alpha = 0;
    _scoreLabel.alpha = 0; _timeLabel.alpha = 0; _counterLabel.alpha = 0;
    for (UIButton * button in _buttonCollection) {
        button.enabled = NO;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    //startup animation
    [UIView animateWithDuration:0.5 animations:^{
        _dotsView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        _dotsView.alpha = 1;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            _dotsView.transform = CGAffineTransformMakeScale(1, 1);
            _scoreLabel.alpha = 1; _timeLabel.alpha = 1; _counterLabel.alpha = 1;
        }completion:^(BOOL finished) {
            //timer for starting game
            Countdowntimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Countdown) userInfo:nil repeats:YES];
        }];
    }];
    //
}
int startTimerVal = 0;
-(void) Countdown{
    startTimerVal ++;
    if (startTimerVal == 3) {
        [Countdowntimer invalidate];
        Countdowntimer = nil;
        [self start];
    }
}
-(void) start{
    timeInt = 1;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeFrame) userInfo:nil repeats:YES];
    [self changeButton];
}

-(void)timeFrame{
    timeInt = timeInt - 0.01;
    if(timeInt > 0){
    [_timeLabel setText:[NSString stringWithFormat:@"%0.2fs",timeInt]];
    }
    else{
        [_timeLabel setText:@"0.00s"];
        timer = nil; [timer invalidate];
    }
}
- (IBAction)one:(id)sender {
    [self changeButton];
}
- (IBAction)two:(id)sender {
    [self changeButton];

}
- (IBAction)three:(id)sender {
    [self changeButton];

}
- (IBAction)four:(id)sender {
    [self changeButton];

}
- (IBAction)five:(id)sender {
    [self changeButton];

}
- (IBAction)six:(id)sender {
    [self changeButton];

}

- (IBAction)seven:(id)sender {
    [self changeButton];

    
}
- (IBAction)eight:(id)sender {
    [self changeButton];

    
}
- (IBAction)nine:(id)sender {
    [self changeButton];

}
//called for every button press
-(void) changeButton{
    timeInt = timeInt + 0.25;
    int rand = arc4random()%9;
    int i = -1;
    for (UIButton *button in _buttonCollection) {
        i++;
        if (i == rand) {
            button.enabled = YES;
        }
        else{
            button.enabled = NO;
        }
    }
    int j = -1;
    //animation
    for(UIImageView *imge in _imageCollection){
        j ++;
        if (j == rand) {
            [UIView animateWithDuration:0.1 animations:^{
                imge.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    imge.transform= CGAffineTransformMakeScale(1, 1);
                }];
            }];
        }
    }
}

@end
