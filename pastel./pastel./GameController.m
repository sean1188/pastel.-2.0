//
//  GameController.m
//  pastel.
//
//  Created by Seannn! on 5/1/17.
//  Copyright © 2017 tangentinc. All rights reserved.
//

#import "GameController.h"

@interface GameController ()

@end

@implementation GameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController popToRootViewControllerAnimated:NO];
}



@end
