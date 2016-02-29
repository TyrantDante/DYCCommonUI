//
//  UIScrollView+DYC.m
//  DYCCommonUI
//
//  Created by Dante on 16/2/29.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "UIScrollView+DYC.h"

@implementation UIScrollView (DYC)
- (void)setHeader:(UIView *)header{
    self.contentInset = UIEdgeInsetsMake(-header.frame.size.height, 0, 0, 0);
    [self insertSubview:header atIndex:0];
    [self contentOffset];
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@",object);
    NSLog(@"%@",[self valueForKey:keyPath]);
}
@end
