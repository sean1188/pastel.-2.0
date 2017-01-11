//
//  ViewController.h
//  pastel.
//
//  Created by Sean Lim on 11/11/16.
//  Copyright © 2016 tangentinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;

- (IBAction)playButton:(id)sender;
- (IBAction)soundButton:(id)sender;

@end

