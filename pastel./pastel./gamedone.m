//
//  gamedone.m
//  pastel.
//
//  Created by Seannn! on 10/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import "gamedone.h"

@interface gamedone ()

@end

@implementation gamedone
int gameScore_;
int highScore;
- (void)viewDidLoad {
    [super viewDidLoad];
    // fetch score and highscore
    gameScore_ = [[[NSUserDefaults standardUserDefaults] objectForKey:@"score"] intValue];
    highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"]intValue];
    if (gameScore_ > highScore) {
        [_headerTextView setText:@"H I G H S C O R E !"];
        [_highscoreSubHeader setText:@""];
        [_scoreLabell setText:[NSString stringWithFormat:@"%i",gameScore_]];
        [[NSUserDefaults standardUserDefaults] setInteger:gameScore_ forKey:@"highScore"];
    }
    else{
        [_headerTextView setText:@"S C O R E :"];
        [_highscoreSubHeader setText:[NSString stringWithFormat:@"Highscore : %i",[[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] intValue]]];
        [_scoreLabell setText:[NSString stringWithFormat:@"%i",gameScore_]];
    }
    //setup animation
    for (UIButton *b in _buttonCollection) {
        b.layer.cornerRadius = 25.0f;
        b.layer.shadowOpacity = 0.3;
        b.layer.shadowOffset = CGSizeMake(1, 3);
        b.layer.shadowRadius = 2;
    }
    
}
- (IBAction)Done:(id)sender {
    //animate out
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)share:(id)sender {
}

@end
