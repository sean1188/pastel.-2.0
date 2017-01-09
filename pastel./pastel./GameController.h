//
//  GameController.h
//  pastel.
//
//  Created by Seannn! on 5/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface GameController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *dotsView;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageCollection;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end
