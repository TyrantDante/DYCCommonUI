//
//  DYCClassSelectedView.h
//  CommonUI
//
//  Created by NaXing on 16/2/18.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYCClassSelectedView;
@protocol DYCClassSelectedViewDelegate<NSObject>
- (NSInteger)rowInSelectView:(DYCClassSelectedView *)selectView;
- (NSInteger)columnInSelectView:(DYCClassSelectedView *)selectView;
- (BOOL)statusAtRow:(NSInteger)row column:(NSInteger)column selectView:(DYCClassSelectedView *)selectView;
@end
@interface DYCClassSelectedView : UIView
@property (nonatomic,assign) id<DYCClassSelectedViewDelegate> delegate;
- (void)setSelect:(BOOL)select byRow:(NSInteger)row;
- (void)setSelect:(BOOL)select byColumn:(NSInteger)column;
@end
