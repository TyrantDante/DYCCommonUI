//
//  DTNormalHeader.m
//  DTRefresh
//
//  Created by Dante on 16/7/18.
//  Copyright © 2016年 Dante. All rights reserved.
//

#import "DTNormalHeader.h"

@implementation DTNormalHeader
- (void)scrollViewContentOffSetChanged:(NSDictionary *)change{
    [super scrollViewContentOffSetChanged:change];
    if (self.window == nil) return;
    CGFloat offSetY = self.parentScrollView.contentOffset.y;
    
    UIEdgeInsets svInset = self.parentScrollView.contentInset;
    
    CGFloat insetTop = svInset.top;
    CGFloat beginRefreshOffsetY = insetTop + self.frame.size.height;
    
    //up scroll
    if (-insetTop < offSetY) return;
    
    if (self.dt_state == DTRefreshNormal) {
        if (self.parentScrollView.isDragging) {
            self.dt_state = DTRefreshPulling;
        }
    } else if (self.dt_state == DTRefreshPulling){
        if (!self.parentScrollView.isDragging && beginRefreshOffsetY < offSetY) {
            self.dt_state = DTRefreshEndPulling;
        } else if (!self.parentScrollView.isDragging && beginRefreshOffsetY == offSetY){
            self.dt_state = DTRefreshEndPulling;
        } else if (!self.parentScrollView.isDragging && beginRefreshOffsetY > offSetY){
            self.dt_state = DTRefreshNormal;
        }
    } else if (self.dt_state == DTRefreshEndPulling){
        if (!self.parentScrollView.isDragging && beginRefreshOffsetY == offSetY)
            [self startRefresh];
    }
}

- (void)setDt_state:(DTRefreshState)dt_state{
    if (dt_state == self.dt_state) return;
    
    if (dt_state == DTRefreshNormal) {
        if (self.dt_state != DTRefreshDidRefreshed) return;
        //state 完成
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    frame.origin.y = - self.frame.size.height - self.parentScrollView.contentInset.top;
    self.frame = frame;
}
@end
