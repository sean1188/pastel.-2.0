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
@end

@implementation GameController
//basic game mechanic variables
NSTimer *Countdowntimer;
NSTimer *timer;
float timeInt;
int gameScore;
//combo variables
NSTimer *comboTimer;
bool userOnFire;
int comboCounter = 1;
- (void)viewDidLoad {
    [super viewDidLoad];
    //  additional setup for animation after loading the view.
    _blurview.alpha = 0;
    _blurview.frame = self.view.frame;
    _redView.alpha = 0;
    _dotsView.layer.cornerRadius = 15.0f;
    _dotsView.layer.shadowRadius = 3; _dotsView.layer.shadowOpacity = 0.3; _dotsView.layer.shadowOffset = CGSizeMake(1, 3);
    _dotsView.transform = CGAffineTransformMakeScale(0, 0); _dotsView.alpha = 0;
    _scoreLabel.alpha = 0; _timeLabel.alpha = 0; _counterLabel.alpha = 0;
    for (UIButton * button in _buttonCollection) {
        button.enabled = NO;
    }
    //setup game timer and score
    startTimerVal = 0;
    comboCounter = 1;
    timeInt = 2;
    [_timeLabel setText:[NSString stringWithFormat:@"%0.2f",timeInt]];
    gameScore = 0;
    [_scoreLabel setText:@"000"];

    
}
-(void)viewDidAppear:(BOOL)animated{
    //startup animation
    [UIView animateWithDuration:0.2 animations:^{
        _dotsView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        _dotsView.alpha = 1;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _dotsView.transform = CGAffineTransformMakeScale(1, 1);
            _scoreLabel.alpha = 1; _timeLabel.alpha = 1; _counterLabel.alpha = 1;
        }completion:^(BOOL finished) {
            //timer for starting game
            [UIView animateWithDuration:0.2 animations:^{
                _blurview.alpha = 1;
            }];
            Countdowntimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Countdown) userInfo:nil repeats:YES];
        }];
    }];
    //
}
int startTimerVal = 0;
-(void) Countdown{
    startTimerVal ++;
    [_countdownLabel setText:[NSString stringWithFormat:@"%i", ( 3-startTimerVal)]];
    if (startTimerVal == 3) {
        [UIView animateWithDuration:0.1 animations:^{
            _blurview.alpha = 0;
        }];
        [Countdowntimer invalidate];
        Countdowntimer = nil;
        [self start];
    }
}
-(void) start{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeFrame) userInfo:nil repeats:YES];
    [self changeButton];
    userOnFire = YES;
    comboTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(comboTimeLimit) userInfo:nil repeats:NO];
}

-(void) comboTimeLimit{
    userOnFire = NO;
    comboCounter = 1;
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
        //game over
        [timer invalidate];
        timer = nil;
        [_timeLabel setText:@"0.00s"];
        for (UIButton *b in _buttonCollection) {
            b.enabled = NO;
        }
        //game over animation
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        [UIView animateWithDuration:0.2 animations:^{
            _scoreLabel.alpha = 0;
            _timeLabel.alpha = 0;
            _counterLabel.alpha = 0;
            _redView.alpha = 0;
            _dotsView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _dotsView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            }completion:^(BOOL finished) {
                //init scoreview
                [[NSUserDefaults standardUserDefaults] setInteger:gameScore forKey:@"score"];
                [self performSegueWithIdentifier:@"gamedone" sender:self];
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
    //increase time
    switch (arc4random()%4) {
        case 0:
            timeInt = timeInt + 0.4;
            break;
        case 1:
            timeInt = timeInt + 0.3;
            break;
        case 2:
            timeInt = timeInt + 0.2;
            break;
            case 3:
            timeInt = timeInt + 0.3;
            break;
        default:
            break;
    }
    //score computing & combo timer config
    [comboTimer invalidate]; comboTimer = nil;
    if (userOnFire == YES) {
        comboCounter ++;
        [UIView animateWithDuration:0.1 animations:^{
            _counterLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                _counterLabel.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }];
    }
    gameScore = gameScore + (10 *comboCounter);
    [_counterLabel setText:[NSString stringWithFormat:@"%ix",comboCounter]];
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
                imge.transform = CGAffineTransformMakeScale(1.4, 1.4);
        
            }completion:^(BOOL finished) {
                comboTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(comboTimeLimit) userInfo:nil repeats:NO];
                userOnFire = YES;
                [UIView animateWithDuration:0.1 animations:^{
                    imge.transform= CGAffineTransformMakeScale(1, 1);
                }];
            }];
        }
    }
}

@end
