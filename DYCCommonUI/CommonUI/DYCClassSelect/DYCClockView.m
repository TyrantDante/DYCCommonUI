//
//  DYCClockView.m
//  DYCCommonUI
//
//  Created by Dante on 16/3/8.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCClockView.h"
#define UIColorWithRGB(r, g, b)  [UIColor colorWithRed:(r)/255.f  green:(g)/255.f blue:(b)/255.f alpha:1.f]
@interface DYCClockView()
@property (nonatomic,strong) NSMutableArray *btnArray;
@end
@implementation DYCClockView
- (void)setStartClock:(NSInteger)startClock{
    _startClock = startClock;
    [self initBtnArray];
}

- (void)setEndClock:(NSInteger)endClock{
    _endClock = endClock;
    [self initBtnArray];
}
- (void)setRowNum:(NSInteger)rowNum{
    _rowNum = rowNum;
    [self initBtnArray];
    [self layoutSubviews];
}

- (void)initBtnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    [_btnArray removeAllObjects];
    for (int i = 0; i < _rowNum; i ++) {
        UIButton *button = [self commonBtnWithIndex:i];
        [self addSubview:button];
        [_btnArray addObject:button];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_rowNum) {
        return;
    }
    CGFloat unitHeight = self.frame.size.height /  _rowNum;
    CGFloat unitWidth = self.frame.size.width;
    for (UIButton *button in _btnArray) {
        NSInteger index = [_btnArray indexOfObject:button];
        button.frame = CGRectMake(0, index * unitHeight, unitWidth, unitHeight);
    }
}
- (UIButton *)commonBtnWithIndex:(NSInteger)index{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:UIColorWithRGB(0xd0, 0xd0, 0xd0) forState:UIControlStateNormal];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    NSInteger spaceTime = _endClock - _startClock;
    NSInteger unitSpaceTime = spaceTime / _rowNum;
    NSInteger currentTime = unitSpaceTime * index + _startClock;
    NSString *strCurTime = [NSString stringWithFormat:@"%2ld",currentTime];
    [button setTitle:strCurTime forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        if ([_delegate respondsToSelector:@selector(clockView:didSelectAtIndex:)]) {
            [_delegate clockView:self didSelectAtIndex:[_btnArray indexOfObject:sender]];
        }
        return;
    }
    if ([_delegate respondsToSelector:@selector(clockView:didDeselectAtIndex:)]) {
        [_delegate clockView:self didDeselectAtIndex:[_btnArray indexOfObject:sender]];
    }
}
@end
