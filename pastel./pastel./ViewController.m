//
//  ViewController.m
//  pastel.
//
//  Created by Sean Lim on 11/11/16.
//  Copyright © 2016 tangentinc. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
{
    AVAudioPlayer *player;
}
@end

@implementation ViewController
-(void) viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:0.6 animations:^{
        _logo.alpha = 1;
        _logo.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            _logo.transform = CGAffineTransformMakeScale(1, 1);
            for (UIButton *button in _buttons) {
                button.alpha = 1;
            }
            _soundButton.alpha = 1;
            
            _header.alpha = 1;
        }];
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIButton *button in _buttons) {
        button.alpha = 0;
        button.layer.cornerRadius = 30;
        button.layer.shadowOpacity = 0.2;
        button.layer.shadowOffset = CGSizeMake(1, 3);
        button.layer.shadowRadius = 2;
    }
    _logo.alpha = 0;
    _logo.transform = CGAffineTransformMakeScale(0, 0);
    _header.alpha = 0; _soundButton.alpha = 0;
}

- (IBAction)playButton:(id)sender {
    //button sound
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"play"  ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    player.delegate = self;
    [player prepareToPlay];
    [player play];
    //init exit animations
    [UIView animateWithDuration:0.5 animations:^{
        _logo.transform = CGAffineTransformMakeScale(0, 0);
        _header.alpha = 0;
        for (UIButton *button in _buttons) {
            button.alpha = 0;
        }
        _soundButton.alpha = 0;
    }completion:^(BOOL finished) {
        [self performSegueWithIdentifier:@"game" sender:self];
    }];
}

- (IBAction)soundButton:(id)sender {
}
@end
