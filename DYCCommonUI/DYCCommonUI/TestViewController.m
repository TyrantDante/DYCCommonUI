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
#import "DYCNormalTeachTimeSetView.h"
@interface TestViewController()
@property (nonatomic,strong) DYCEvaluationPopUp *popUpView;
@end
@implementation TestViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self text11];
}

- (void)text11{
    self.navigationController.navigationBarHidden = YES;
    DYCNormalTeachTimeSetView *selectView = [[DYCNormalTeachTimeSetView alloc] init];
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
    selectView.frame = frame;
    [self.view addSubview:selectView];
}

- (void)text2{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"12313";
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_comment_close"] style:UIBarButtonItemStyleDone target:self action:@selector(itemClicked:)];
//    self.navigationItem.leftBarButtonItem = item;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
    view.backgroundColor = [UIColor yellowColor];
    tableView.dyc_header = view;
}
- (void)itemClicked:(id)sender{
    NSLog(@"12312313123");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ce11"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ce11"];
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row ];
    return cell;
}
- (void)text{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"12313";
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
    //    view.backgroundColor = [UIColor yellowColor];
    //
    ////
    //    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //    sv.contentSize = CGSizeMake(self.view.bounds.size.width, 1500);
    //    [sv setContentFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1500)];
    //
    //    sv.dyc_header = view;
    //    self.view = sv;
    //    UIButton *view2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 50)];
    //    [view2 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    //    view2.backgroundColor = [UIColor blueColor];
    //    [self.view addSubview:view2];
    DYCBigEvaHeartView *bigview = [[DYCBigEvaHeartView alloc] init];
    bigview.numOfItem = 10;
    [self.view addSubview:bigview];
    bigview.frame = CGRectMake(0, 100, 300, 10);
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
    DYCLitteEvaHeartView *litView = [[DYCLitteEvaHeartView alloc] initWithTotalScroe:5 curScore:3];
    litView.frame = CGRectMake(self.view.frame.size.width - 100 - 15, 300, 100, 8);
    [self.view addSubview:litView];
    //
    //    UILabel *label = [[UILabel alloc] init];
    //    label.text = @"12123";
    //    label.frame  = CGRectMake(0, 400, 100, 100);
    //    [self.view addSubview:label];
    //
    _popUpView = [[DYCEvaluationPopUp alloc] init];
    
    _popUpView.frame = [DYCEvaluationPopUp frameForPopUp];;
    [_popUpView showInView:self.view];
    [_popUpView hide];
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    //    button.frame = CGRectMake(0, 500, 100, 50);
    //    button.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:button];
}

@end
