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
- (void)didSelectAtRow:(NSInteger)row column:(NSInteger)column status:(BOOL)staus;
@end


@interface DYCClassSelectedView : UIScrollView
@property (nonatomic,assign) id<DYCClassSelectedViewDelegate> classDelegate;
@property (nonatomic,assign) BOOL canSlidToSelect;
- (void)setSelect:(BOOL)select byRow:(NSInteger)row;
- (void)setSelect:(BOOL)select byColumn:(NSInteger)column;
@end
