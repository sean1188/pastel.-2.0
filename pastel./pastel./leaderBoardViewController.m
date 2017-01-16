//
//  leaderBoardViewController.m
//  pastel.
//
//  Created by Seannn! on 12/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import "leaderBoardViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "CollectionViewCell.h"
@interface leaderBoardViewController ()
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation leaderBoardViewController
NSDictionary *entries;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _topview.layer.shadowOpacity = 0.5;
    _topview.layer.shadowOffset = CGSizeMake(2, 1);
    _topview.layer.shadowRadius = 2;
    _topview.layer.shadowPath = [UIBezierPath bezierPathWithRect:_topview.bounds].CGPath;
    [_scoreLabel setText:[NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]]];
    //
    self.ref = [[FIRDatabase database] reference];
    //sign in and fetch scores
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {NSLog(@"%@",error.description);}
        [[self.ref child:@"leaderboard"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            NSLog(@"%@", snapshot.value);
            entries = snapshot.value;
            [_collectionView reloadData];
        }
         withCancelBlock:^(NSError * _Nonnull error) {
             NSLog(@"%@",error.description);
         }
         ];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[entries allKeys] count];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (UICollectionViewCell  *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *key = [entries allKeys];
    [cell.name setText:[NSString stringWithFormat:@"%@",[key objectAtIndex:indexPath.row]]];
    [cell.indexLabel setText:[NSString stringWithFormat:@"%li.",indexPath.row +1]];
    [cell.scoreLabel setText:[NSString stringWithFormat:@"%@",[[entries objectForKey:[key objectAtIndex:indexPath.row]] objectForKey:@"score"]]];
    return cell;
}



@end
