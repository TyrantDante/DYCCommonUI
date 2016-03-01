//
//  UIScrollView+DYC.h
//  DYCCommonUI
//
//  Created by Dante on 16/2/29.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (DYC)
@property (nonatomic,strong) UIView *header;
@property (nonatomic,strong) NSString *oldSize;
- (void)setContentFrame:(CGRect)frame;
@end
