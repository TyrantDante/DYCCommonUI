//
//  DYCCarouselView.m
//  DYCCommonUI
//
//  Created by Dante on 16/3/9.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCCarouselView.h"
@interface DYCCarouselView()
@property (nonatomic,strong) UIView *curView;
@property (nonatomic,strong) UIView *moveView;
@end
@implementation DYCCarouselView
- (instancetype)init{
    if (self = [super init]) {
        _curView = [[UIView alloc] init];
        [self addSubview:_curView];
        
        _moveView = [[UIView alloc] init];
        [self addSubview:_moveView];
        
        UISwipeGestureRecognizer *swipeGesRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesInvoke:)];
        [swipeGesRight setDirection:UISwipeGestureRecognizerDirectionRight];
        UISwipeGestureRecognizer *swipeGesLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesInvoke:)];
        [swipeGesLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:swipeGesRight];
        [self addGestureRecognizer:swipeGesLeft];
    }
    return self;
}
- (void)swipGesInvoke:(UISwipeGestureRecognizer *)swipeGes{
    if (swipeGes.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self swipLeft];
    }
    if (swipeGes.direction == UISwipeGestureRecognizerDirectionRight) {
        [self swipRight];
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _curView.frame = self.bounds;
    _moveView.frame = self.bounds;
}

- (void)setDelegate:(id<DYCCarouselViewDelegate>)delegate{
    _delegate = delegate;
    if ([_delegate respondsToSelector:@selector(carouselView:currentView:)]) {
        _curView = [_delegate carouselView:self currentView:_curView];
    }
}

- (void)swipLeft{
    if ([_delegate respondsToSelector:@selector(carouselView:nextView:)]) {
        _moveView = [_delegate carouselView:self nextView:_moveView];
        CGRect moveStartFrame = _moveView.frame;
        moveStartFrame.origin.x = moveStartFrame.size.width;
        _moveView.frame = moveStartFrame;
        
        CGRect moveEndFrame = _moveView.frame;
        moveEndFrame.origin.x = 0;
        CGRect currentEndFrame = _curView.frame;
        currentEndFrame.origin.x = - currentEndFrame.size.width;
        
        [UIView animateWithDuration:0.3 animations:^{
            _moveView.frame = moveEndFrame;
            _curView.frame = currentEndFrame;
        }];
        UIView *view = _curView;
        _curView = _moveView;
        _moveView = view;
    }
}

- (void)swipRight{
    if ([_delegate respondsToSelector:@selector(carouselView:lastView:)]) {
        _moveView = [_delegate carouselView:self lastView:_moveView];
        CGRect moveStartFrame = _moveView.frame;
        moveStartFrame.origin.x = - moveStartFrame.size.width;
        _moveView.frame = moveStartFrame;
        
        CGRect moveEndFrame = _moveView.frame;
        moveEndFrame.origin.x = 0;
        CGRect currentEndFrame = _curView.frame;
        currentEndFrame.origin.x = currentEndFrame.size.width;
        
        [UIView animateWithDuration:0.3 animations:^{
            _moveView.frame = moveEndFrame;
            _curView.frame = currentEndFrame;
        }];
        UIView *view = _curView;
        _curView = _moveView;
        _moveView = view;
    }
}
@end
