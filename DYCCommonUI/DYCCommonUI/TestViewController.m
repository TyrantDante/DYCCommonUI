//
//  TestViewController.m
//  DYCCommonUI
//
//  Created by NaXing on 16/2/26.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "TestViewController.h"
#import "DYCBigEvaHeartView.h"
@implementation TestViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    DYCBigEvaHeartView *bigview = [[DYCBigEvaHeartView alloc] init];
    bigview.numOfItem = 10;
    [self.view addSubview:bigview];
    bigview.frame = CGRectMake(0, 100, 300, 50);
    
    DYCBigEvaHeartView *bigview2 = [[DYCBigEvaHeartView alloc] init];
    bigview2.numOfItem = 3;
    [self.view addSubview:bigview2];
    bigview2.frame = CGRectMake(0, 200, 300, 50);
}
@end
