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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation leaderBoardViewController
NSDictionary *entries;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _activityView.alpha = 1;
    _H1.layer.shadowRadius = 1;
    _H1.layer.shadowOpacity = 0.3;
    _H1.layer.shadowOffset = CGSizeMake(0, 3);
    _topview.layer.shadowOpacity = 0.5;
    _topview.layer.shadowOffset = CGSizeMake(2, 1);
    _topview.layer.shadowRadius = 2;
    _topview.layer.shadowPath = [UIBezierPath bezierPathWithRect:_topview.bounds].CGPath;
    [_scoreLabel setText:[NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]]];
    //
    self.ref = [[FIRDatabase database] reference];
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"username"]) {
        //initusername
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"Hi there!" message:@"Enter a username" preferredStyle:UIAlertControllerStyleAlert];
        [a addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
           textField.placeholder = @"Username";
            textField.borderStyle = UITextBorderStyleRoundedRect;
        }];
        [a addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (![a.textFields[0].text isEqualToString:@""]) {
                [[NSUserDefaults standardUserDefaults] setObject:a.textFields[0].text forKey:@"username"];
                //send first score
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] != nil) {
                    [[[self.ref child:@"leaderboard"] child:[[NSUserDefaults standardUserDefaults] stringForKey:@"username"]] setValue:@{@"score": [[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"]}];
                }
                
                
                [self fetchLeaderboards];
            }
            
        }]];
        [self presentViewController:a animated:YES completion:nil];
    }
    else{
        //update user score
        [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            [[[self.ref child:@"leaderboard"] child:[[NSUserDefaults standardUserDefaults] stringForKey:@"username"]] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                if ([[snapshot.value objectForKey:@"score"] intValue] < [[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]) {
                    //update highscore
                    NSDictionary *childUpdates = @{[@"/leaderboard/" stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"username"]]: @{@"score" : [[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"]}};
                    NSLog(@"%@", childUpdates);
                    [_ref updateChildValues:childUpdates];
                    [self fetchLeaderboards];
                }
                else{
                    [self fetchLeaderboards];
                }
            }
                                                                                                                            withCancelBlock:^(NSError * _Nonnull error) {
                                                                                                                                   NSLog(@"%@",error.description);
                                                                                                                                UIAlertController *a = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                                                                                                                                [a addAction:[UIAlertAction actionWithTitle:@"okay" style:UIAlertActionStyleCancel handler:nil]];
                                                                                                                                [self presentViewController:a animated:YES completion:nil];
                                                                                                                                
                                                                                                                            
                                                                                                                }];
        }];
        
    }
    
}

-(void) fetchLeaderboards{
    //sign in and fetch scores
    self.ref = [[FIRDatabase database] reference];
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {NSLog(@"%@",error.description);}
        [[self.ref child:@"leaderboard"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            NSLog(@"%@", snapshot.value);
            entries = snapshot.value;
            [_collectionView reloadData];
            _activityView.alpha = 0;
        }
        withCancelBlock:^(NSError * _Nonnull error) {
                                              NSLog(@"%@",error.description);
            UIAlertController *a = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [a addAction:[UIAlertAction actionWithTitle:@"okay" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:a animated:YES completion:nil];
            _activityView.alpha = 0;
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
    cell.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        cell.alpha = 1;
    }];
    //sort algorithm
    NSArray *key = [entries keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([[obj1 objectForKey:@"score"] integerValue] > [[obj2 objectForKey:@"score"]integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([[obj1 objectForKey:@"score"] integerValue] < [[obj2 objectForKey:@"score"] integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    [cell.name setText:[NSString stringWithFormat:@"%@",[key objectAtIndex:indexPath.row]]];
    [cell.indexLabel setText:[NSString stringWithFormat:@"%li.",indexPath.row +1]];
    [cell.scoreLabel setText:[NSString stringWithFormat:@"%@",[[entries objectForKey:[key objectAtIndex:indexPath.row]] objectForKey:@"score"]]];
    return cell;
}

- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}


@end
