//
//  GameController.m
//  pastel.
//
//  Created by Seannn! on 5/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import "GameController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface GameController ()
@property (nonatomic, retain) NSTimer *timer;
@end

@implementation GameController
//basic game mechanic variables
NSTimer *Countdowntimer;
float timeInt;
int gameScore;
//combo variables
NSTimer *comboTimer;
- (void)viewDidLoad {
    [super viewDidLoad];
    //  additional setup for animation after loading the view.
    _redView.alpha = 0;
    _dotsView.layer.cornerRadius = 15.0f;
    _dotsView.layer.shadowRadius = 3; _dotsView.layer.shadowOpacity = 0.3; _dotsView.layer.shadowOffset = CGSizeMake(1, 3);
    _dotsView.transform = CGAffineTransformMakeScale(0, 0); _dotsView.alpha = 0;
    _scoreLabel.alpha = 0; _timeLabel.alpha = 0; _counterLabel.alpha = 0;
    for (UIButton * button in _buttonCollection) {
        button.enabled = NO;
    }
    //setup game timer and score
    timeInt = 2;
    [_timeLabel setText:[NSString stringWithFormat:@"%0.2f",timeInt]];
    gameScore = 0;
    [_scoreLabel setText:@"000"];

    
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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeFrame) userInfo:nil repeats:YES];
    [self changeButton];
}

-(void)timeFrame{
    //main timer function
    timeInt = timeInt - 0.01;
    if(timeInt > 0){
        //update background color
        _redView.alpha = 0.8- (timeInt /1);
        //update time label
        [_timeLabel setText:[NSString stringWithFormat:@"%0.2fs",timeInt]];
    }
    else{
        [self.timer invalidate];
        self.timer = nil;
        [_timeLabel setText:@"0.00s"];
        for (UIButton *b in _buttonCollection) {
            b.enabled = NO;
        }
        //game over animation
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        [UIView animateWithDuration:0.2 animations:^{
            _dotsView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _dotsView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            }completion:^(BOOL finished) {
                //init scoreview
                
            }];
        }];
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
    //increase time and score (normal)
    timeInt = timeInt + 0.4;
    gameScore = gameScore + 5;
    [_scoreLabel setText:[NSString stringWithFormat:@"%i", gameScore]];
    //init next button
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
    //animation
    int j = -1;
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
