//
//  DYCClassShowDifView.m
//  DYCCommonUI
//
//  Created by Dante on 16/3/8.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCClassShowDifView.h"
#define UIColorWithRGB(r, g, b)  [UIColor colorWithRed:(r)/255.f  green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define TAG_NOTVIEW     1001
#define TAG_DOVIEW      1002
#define TAG_NOTLABEL    1003
#define TAG_DOLABEL     1004
@implementation DYCClassShowDifView
- (instancetype)init{
    if (self = [super init]) {
        UIImageView *notView = [[UIImageView alloc] init];
        notView.backgroundColor = [UIColor whiteColor];
        notView.tag = TAG_NOTVIEW;
        [self addSubview:notView];
        
        UIImageView *doView = [[UIImageView alloc] init];
        doView.backgroundColor = UIColorWithRGB(0x23, 0xc3, 0xc1);
        doView.tag = TAG_DOVIEW;
        [self addSubview:doView];
        
        UILabel *notLabel = [[UILabel alloc] init];
        notLabel.text = @"不授课";
        notLabel.textColor = UIColorWithRGB(0x36, 0x36, 0x36);
        notLabel.font = [UIFont systemFontOfSize:12];
        notLabel.tag = TAG_NOTLABEL;
        [self addSubview:notLabel];
        
        UILabel *doLabel = [[UILabel alloc] init];
        doLabel.text = @"授课";
        doLabel.textColor = UIColorWithRGB(0x36, 0x36, 0x36);
        doLabel.font = [UIFont systemFontOfSize:12];
        doLabel.tag = TAG_DOLABEL;
        [self addSubview:doLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIImageView *notView = [self viewWithTag:TAG_NOTVIEW];
    notView.frame = CGRectMake(0, 5, 10, 10);
    notView.layer.cornerRadius = 5;
    notView.clipsToBounds = YES;
    
    UILabel *notLabel = [self viewWithTag:TAG_NOTLABEL];
    notLabel.frame = CGRectMake(CGRectGetMaxX(notView.frame) + 6, 0, 50, 20);
    UIImageView *doView = [self viewWithTag:TAG_DOVIEW];
    doView.frame = CGRectMake(CGRectGetMaxX(notLabel.frame) + 36, 5, 10, 10);
    doView.layer.cornerRadius = 5;
    doView.clipsToBounds = YES;
    UILabel *doLabel = [self viewWithTag:TAG_DOLABEL];
    doLabel.frame = CGRectMake(CGRectGetMaxX(doView.frame) + 6, 0, 50, 20);
}

@end
