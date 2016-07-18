//
//  DTHeader.m
//  DTRefresh
//
//  Created by Dante on 16/7/12.
//  Copyright © 2016年 Dante. All rights reserved.
//

#import "DTHeader.h"
#import <objc/message.h>

static NSString *const DTRefreshKeyPathContentOffSet = @"contentOffset";
static NSString *const DTRefreshKeyPathContentInset = @"contentInset";
static NSString *const DTRefreshKeyPathContentSize = @"contentSize";
static NSString *const DTRefreshKeyPathState = @"state";
@interface DTHeader()
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecongnizer;
@end
@implementation DTHeader
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Test_Color_BG;
        self.dt_state = DTRefreshNormal;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    [self removeObservers];
    
    if (newSuperview != nil) {
        self.parentScrollView = (UIScrollView *)newSuperview;
        [self addObsevers];
    }
    
}

- (void)addObsevers{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    //contentOffSet
    [self.parentScrollView addObserver:self forKeyPath:DTRefreshKeyPathContentOffSet options:options context:nil];
    //contentSize
    [self.parentScrollView addObserver:DTRefreshKeyPathContentSize forKeyPath:DTRefreshKeyPathContentSize options:options context:nil];
    
    self.panGestureRecongnizer = self.parentScrollView.panGestureRecognizer;
    
    [self.panGestureRecongnizer addObserver:self forKeyPath:DTRefreshKeyPathState options:options context:nil];
}

- (void)removeObservers{
    [self.parentScrollView removeObserver:self forKeyPath:DTRefreshKeyPathContentOffSet];
    [self.parentScrollView removeObserver:self forKeyPath:DTRefreshKeyPathContentSize];
    [self.panGestureRecongnizer removeObserver:self forKeyPath:DTRefreshKeyPathState];
    self.panGestureRecongnizer = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:DTRefreshKeyPathContentOffSet]) {
        // contentOffset change
        [self scrollViewContentOffSetChanged:change];
    }
    
    if ([keyPath isEqualToString:DTRefreshKeyPathState]) {
        // pan gesture state change
        [self panGesturerStatueChanged:change];
    }
    
    if ([keyPath isEqualToString:DTRefreshKeyPathContentSize]) {
        // contentSize change
        [self scrollViewContentSizeChanged:change];
    }
}

#pragma mark subclass implementate
- (void)scrollViewContentSizeChanged:(NSDictionary *)change{
    
}

- (void)scrollViewContentOffSetChanged:(NSDictionary *)change{
    
}

- (void)panGesturerStatueChanged:(NSDictionary *)change{
    
}

#pragma mark refresh

- (void)startRefresh{
    if (self.window) {
        self.dt_state = DTRefreshRefreshing;
    } else {
        self.dt_state = DTRefreshWillRefresh;
        [self setNeedsDisplay];
    }
}

- (void)endRefresh{
    self.dt_state = DTRefreshNormal;
}

- (BOOL)isRefreshing{
    return self.dt_state != DTRefreshNoMoreData && self.dt_state != DTRefreshNormal;
}

#pragma mark call back
- (void)setTarget:(id)target action:(nonnull SEL)action{
    self.refreshingTarget = target;
    self.refreshingAction = action;
}
- (void)callBackRefreshing{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            NSMethodSignature *sig = [[self.refreshingTarget class]instanceMethodSignatureForSelector:self.refreshingAction];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
            [invocation setTarget:self.refreshingTarget];
            [invocation setSelector:self.refreshingAction];
            [invocation invoke];
        }
    });
}
@end
