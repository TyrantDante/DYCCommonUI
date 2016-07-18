//
//  ViewController.m
//  DTRefresh
//
//  Created by Dante on 16/7/12.
//  Copyright © 2016年 Dante. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+DTHeader.h"
#import "DTHeader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    sv.backgroundColor = [UIColor yellowColor];
    CGSize size = self.view.bounds.size;
    size.height *= 2;
    sv.contentSize = size;
    [self.view addSubview:sv];
    DTHeader *header = [[DTHeader alloc] initWithFrame:CGRectMake(0, -100, self.view.bounds.size.width, 100)];
    sv.dt_header = header;
    [header setTarget:self action:@selector(callBack:)];
    [header callBackRefreshing];
}

- (void)callBack:(id)sender{
    NSLog(@"call back");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
