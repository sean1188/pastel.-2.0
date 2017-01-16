//
//  tutViewController.m
//  pastel.
//
//  Created by Seannn! on 11/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import "tutViewController.h"
@interface tutViewController ()
@end

@implementation tutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"meme"] != YES) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"meme"];
        [_insLabel setText:@"Tap the dots that enlarge to score points and earn bonus time."];
    }else{
        switch (arc4random()%3) {
            case 0:
                [_insLabel setText:@"Tap the dots that enlarge to score points and earn bonus time."];
                break;
            case 1:
                [_insLabel setText:@"The faster you tap, the more points you earn with the score multiplier."];
                break;
            case 2:
                [_insLabel setText:@"Compete with other players for the highest score in the leaderboard."];
                break;
            default:
                break;
        }
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(lmao) userInfo:nil repeats:NO];
}
-(void)lmao{
    [self performSegueWithIdentifier:@"next" sender:self];
}

@end
		
