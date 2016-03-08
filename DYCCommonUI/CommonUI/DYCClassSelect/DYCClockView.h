//
//  DYCClockView.h
//  DYCCommonUI
//
//  Created by Dante on 16/3/8.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYCClockView;
@protocol DYCClockViewDelegate<NSObject>
- (void)clockView:(DYCClockView *)clockView didSelectAtIndex:(NSInteger)index;
- (void)clockView:(DYCClockView *)clockView didDeselectAtIndex:(NSInteger)index;
@end
@interface DYCClockView : UIView
@property (nonatomic,assign) id<DYCClockViewDelegate> delegate;
@property (nonatomic,assign) NSInteger startClock;
@property (nonatomic,assign) NSInteger endClock;
@property (nonatomic,assign) NSInteger rowNum;
@end
