//
//  DYCWeekView.h
//  DYCCommonUI
//
//  Created by Dante on 16/3/2.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYCWeekView;
@protocol DYCWeekViewDelegate<NSObject>
- (void)weekView:(DYCWeekView *)weekView didSelectAtIndex:(NSInteger)index;
- (void)weekView:(DYCWeekView *)weekView didDeselectAtIndex:(NSInteger)index;
@end
@interface DYCWeekView : UIView
@property (nonatomic,assign) id<DYCWeekViewDelegate> delegate;
@end
