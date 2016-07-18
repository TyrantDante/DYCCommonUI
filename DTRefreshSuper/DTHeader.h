//
//  DTHeader.h
//  DTRefresh
//
//  Created by Dante on 16/7/12.
//  Copyright © 2016年 Dante. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DTRefreshState) {
    DTRefreshNormal = 1,
    
    DTRefreshPulling,
    
    DTRefreshEndPulling,
    
    DTRefreshRefreshing,
    
    DTRefreshWillRefresh,
    
    DTRefreshDidRefreshed,
    
    DTRefreshNoMoreData
};
@interface DTHeader : UIView
@property (nonatomic, weak) UIScrollView *parentScrollView;

@property (nonatomic, assign) DTRefreshState dt_state;

#pragma mark call back
- (void)setTarget:(nonnull id)target action:(nonnull SEL)action;
@property (nonatomic, weak) id refreshingTarget;
@property (nonatomic, assign,nonnull) SEL refreshingAction;
- (void)callBackRefreshing;

#pragma mark subclass implementate
- (void)scrollViewContentSizeChanged:(NSDictionary *)change;

- (void)scrollViewContentOffSetChanged:(NSDictionary *)change;

- (void)panGesturerStatueChanged:(NSDictionary *)change;
@end
