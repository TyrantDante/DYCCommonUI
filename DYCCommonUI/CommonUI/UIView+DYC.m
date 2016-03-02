//
//  UIView+DYC.m
//  DYCCommonUI
//
//  Created by Dante on 16/3/2.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "UIView+DYC.h"

@implementation UIView (DYC)

- (CGFloat)totalHeight{
    CGFloat height = self.bounds.size.height + self.frame.origin.y;
    return height;
}
- (CGFloat)totalWidth{
    CGFloat width = self.bounds.size.width + self.frame.origin.x;
    return width;
}
@end
