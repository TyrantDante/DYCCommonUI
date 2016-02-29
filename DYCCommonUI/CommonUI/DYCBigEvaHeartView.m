//
//  DYCBigEvaHeartView.m
//  DYCCommonUI
//
//  Created by NaXing on 16/2/26.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCBigEvaHeartView.h"

@implementation DYCBigEvaHeartView
- (instancetype)init{
    self = [super init];
    if (self) {
        _numOfItem = 5;
        _normalImage = [UIImage imageNamed:@"icon_comment_heart_empty"];
        _selectedImage = [UIImage imageNamed:@"icon_comment_heart"];
        for (NSInteger i = 0; i < _numOfItem; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:_normalImage forState:UIControlStateNormal];
            [button setImage:_selectedImage forState:UIControlStateSelected];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.frame.size;
    CGSize itemSize = CGSizeMake(size.width / _numOfItem, size.height);
    for (NSInteger i = 0; i < _numOfItem; i ++) {
        UIButton *button = [self viewWithTag:i + 100];
        button.frame = CGRectMake(i * itemSize.width, 0, itemSize.width, itemSize.height);
    }
}

- (void)buttonClicked:(UIButton *)sender{
    NSInteger score = sender.tag - 100;
    if (_scoreBlock) {
        _scoreBlock(score);
    }
    for (NSInteger i = 100; i <= sender.tag; i ++) {
        UIButton *button = [self viewWithTag:i];
        button.selected = YES;
    }
    for (NSInteger i = sender.tag + 1; i < 100 + _numOfItem; i ++) {
        UIButton *button = [self viewWithTag:i];
        button.selected = NO;
    }
}

- (void)setNumOfItem:(NSInteger)numOfItem{
    if (numOfItem > _numOfItem) {
        for (NSInteger i = _numOfItem; i < numOfItem; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:_normalImage forState:UIControlStateNormal];
            [button setImage:_selectedImage forState:UIControlStateSelected];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        _numOfItem = numOfItem;
        [self layoutSubviews];
        return;
    }
    for (NSInteger i = _numOfItem; i > numOfItem; -- i) {
        [[self viewWithTag:100 + _numOfItem] removeFromSuperview];
    }
    _numOfItem = numOfItem;
    [self layoutSubviews];
}

@end
