//
//  leaderBoardViewController.h
//  pastel.
//
//  Created by Seannn! on 12/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface leaderBoardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *topview;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *H1;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
