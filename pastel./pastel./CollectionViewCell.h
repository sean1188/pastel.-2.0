//
//  CollectionViewCell.h
//  pastel.
//
//  Created by Seannn! on 13/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
