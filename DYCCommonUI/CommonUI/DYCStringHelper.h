//
//  DYCStringHelper.h
//  DYCCommonUI
//
//  Created by Dante on 16/3/7.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DYCStringHelper : NSObject
/*
 功能:  生成富文本
 入参:  字面意思
 返回:  富文本
 注意:   UILabel *label = [[UILabel alloc] init];
 label.attributedText = 【富文本】;
 */
+ (NSAttributedString *)attrStrWithTotalStr:(NSString *)totalStr ttColor:(UIColor *)ttColor ttFont:(UIFont *)ttFont subStr:(NSString *)subStr subColor:(UIColor *)subColor subFont:(UIFont *)subFont;
@end