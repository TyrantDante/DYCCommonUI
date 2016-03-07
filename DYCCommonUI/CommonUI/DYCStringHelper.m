//
//  DYCStringHelper.m
//  DYCCommonUI
//
//  Created by Dante on 16/3/7.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCStringHelper.h"

@implementation DYCStringHelper
+ (NSAttributedString *)attrStrWithTotalStr:(NSString *)totalStr ttColor:(UIColor *)ttColor ttFont:(UIFont *)ttFont subStr:(NSString *)subStr subColor:(UIColor *)subColor subFont:(UIFont *)subFont{
    NSAssert(![totalStr containsString:subStr], @"totalStr not contains subStr");
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    NSDictionary *ttDict = @{NSForegroundColorAttributeName:ttColor,NSFontAttributeName:ttFont};
    NSDictionary *subDict = @{NSForegroundColorAttributeName:subColor,NSFontAttributeName:subFont};
    [attrStr setAttributes:ttDict range:[totalStr rangeOfString:totalStr]];
    [attrStr setAttributes:subDict range:[totalStr rangeOfString:subStr]];
    return attrStr;
}

@end

