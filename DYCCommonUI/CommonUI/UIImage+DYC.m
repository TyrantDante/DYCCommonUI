//
//  UIImage+DYC.m
//  DYCCommonUI
//
//  Created by Dante on 16/3/7.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "UIImage+DYC.h"

@implementation UIImage (DYC)
+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
