//
//  DYCLitteEvaHeartView.m
//  DYCCommonUI
//
//  Created by NaXing on 16/2/26.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCLitteEvaHeartView.h"
#define HEART_IMAGE @"icon_heart"
#define HEART_EMPTY_IMAGE @"heart_gray"
@interface DYCLitteEvaHeartView()

//default is 0
@property (nonatomic,assign) NSInteger curScore;
//default is 5
@property (nonatomic,assign) NSInteger totalScore;

@end
@implementation DYCLitteEvaHeartView

- (instancetype)initWithTotalScroe:(NSInteger)totalScore curScore:(NSInteger)curScore{
    self = [super init];
    if (self) {
        _totalScore = totalScore;
        _curScore = curScore;
        for (NSInteger i = 0; i < totalScore; i ++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.tag = 100 + i;
            [self addSubview:imageView];
            if (i >= curScore) {
                imageView.image = [UIImage imageNamed:HEART_EMPTY_IMAGE];
            } else {
                imageView.image = [UIImage imageNamed:HEART_IMAGE];
            }
        }
    }
    return self;
}
- (void)setCurrentScore:(NSInteger)currentScore{
    _currentScore = currentScore;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    for (NSInteger i = 0; i < _totalScore; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = 100 + i;
        [self addSubview:imageView];
        if (i >= currentScore) {
            imageView.image = [UIImage imageNamed:HEART_EMPTY_IMAGE];
        } else {
            imageView.image = [UIImage imageNamed:HEART_IMAGE];
        }
    }
    [self layoutSubviews];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.frame.size;
    CGSize itemSize = CGSizeMake(size.width / _totalScore, size.height);
    for (NSInteger i = 0; i < _totalScore; i ++) {
        UIImageView *imageView = [self viewWithTag:i + 100];
        imageView.frame = CGRectMake(i * itemSize.width, 0, itemSize.width, itemSize.height);
    }
}

@end
