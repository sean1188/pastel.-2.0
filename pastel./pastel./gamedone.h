//
//  gamedone.h
//  pastel.
//
//  Created by Seannn! on 10/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gamedone : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoHead;
@property (weak, nonatomic) IBOutlet UILabel *headerTextView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabell;
@property (weak, nonatomic) IBOutlet UILabel *highscoreSubHeader;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;

@end
