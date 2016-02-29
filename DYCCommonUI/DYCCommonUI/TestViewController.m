//
//  TestViewController.m
//  DYCCommonUI
//
//  Created by NaXing on 16/2/26.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "TestViewController.h"
#import "DYCBigEvaHeartView.h"
#import "DYCLitteEvaHeartView.h"
#import "DYCHolderTextView.h"
#import "DYCEvaluationPopUp.h"
#import "UIScrollView+DYC.h"
@interface TestViewController()
@property (nonatomic,strong) DYCEvaluationPopUp *popUpView;
@end
@implementation TestViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    sv.contentSize = CGSizeMake(1000, 10000);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 110)];
    view.backgroundColor = [UIColor yellowColor];
    sv.header = view;
    self.view = sv;
    
//    DYCBigEvaHeartView *bigview = [[DYCBigEvaHeartView alloc] init];
//    bigview.numOfItem = 10;
//    [self.view addSubview:bigview];
//    bigview.frame = CGRectMake(0, 100, 300, 50);
//    
//    DYCTextView *textView = [[DYCTextView alloc] init];
//    textView.placeHolder = @"你想说的话……";
//    textView.font = [UIFont systemFontOfSize:13];
//    textView.frame = CGRectMake(0, 150, 200, 200);
//    textView.clipsToBounds = YES;
//    textView.layer.cornerRadius = 5;
//    textView.layer.borderWidth = 1;
//    textView.layer.borderColor = [UIColor grayColor].CGColor;
//    [self.view addSubview:textView];
//    
//    DYCLitteEvaHeartView *litView = [[DYCLitteEvaHeartView alloc] initWithTotalScroe:5 curScore:3];
//    litView.frame = CGRectMake(0, 300, 100, 50);
//    [self.view addSubview:litView];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"12123";
//    label.frame  = CGRectMake(0, 400, 100, 100);
//    [self.view addSubview:label];
//    
//    _popUpView = [[DYCEvaluationPopUp alloc] init];
//    _popUpView.frame = CGRectMake(20, (self.view.frame.size.height - 495) / 2, self.view.frame.size.width - 40, 495);
//    [_popUpView showInView:self.view];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 500, 100, 50);
//    button.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button];
}

- (void)buttonClicked{
    [_popUpView showInView:self.view];
}
@end
