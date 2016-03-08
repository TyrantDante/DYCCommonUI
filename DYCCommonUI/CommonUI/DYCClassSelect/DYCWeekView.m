//
//  DYCWeekView.m
//  DYCCommonUI
//
//  Created by Dante on 16/3/2.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCWeekView.h"
#define UIColorWithRGB(r, g, b)  [UIColor colorWithRed:(r)/255.f  green:(g)/255.f blue:(b)/255.f alpha:1.f]
@interface DYCWeekView()
@property (nonatomic,strong) NSArray *weekArray;
@end
@implementation DYCWeekView
- (instancetype)init{
    self = [super init];
    if (self) {
        _weekArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
        for (int i = 0; i < _weekArray.count; i ++) {
            UIColor *color = UIColorWithRGB(0x66, 0x66, 0x66);
            [self commonButtonWithColor:color font:[UIFont boldSystemFontOfSize:12] tag:100 + i title:_weekArray[i]];
            
        }
    }
    return self;
}

- (UIButton *)commonButtonWithColor:(UIColor *)textColor font:(UIFont *)font tag:(NSInteger)tag title:(NSString *)title{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = font;
    button.tag = tag;
    [self addSubview:button];
    return button;
}

- (void)buttonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        if ([_delegate respondsToSelector:@selector(weekView:didSelectAtIndex:)]) {
            [_delegate weekView:self didSelectAtIndex:sender.tag - 100];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(weekView:didDeselectAtIndex:)]) {
            [_delegate weekView:self didDeselectAtIndex:sender.tag - 100];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width / _weekArray.count;
    CGFloat height = self.frame.size.height;
    for (int i = 100; i < 100 + _weekArray.count; i ++) {
        UIButton *button = [self getButtonByTag:i];
        NSInteger index = i - 100;
        button.frame = CGRectMake(index * width, 0, width, height);
    }
}

- (UIButton *)getButtonByTag:(NSInteger)tag{
    UIButton *button = [self viewWithTag:tag];
    return button;
}
@end
