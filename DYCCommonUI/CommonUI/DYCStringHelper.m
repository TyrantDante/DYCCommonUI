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

+ (NSString *)pathBySaveImage:(UIImage *)image{
    bool success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docDict = [paths objectAtIndex:0];
    NSString *imageFilePath = [docDict stringByAppendingString:@"/rejectImage.jpg"];
    NSLog(@"imageFilePath - >> %@",imageFilePath);
    NSString *path = [[NSHomeDirectory()stringByAppendingString:@"Documents"] stringByAppendingString:@"/rejectImage.jpg"];
    NSLog(@"NSHomeDirectory= %@\npath=%@",NSHomeDirectory(),path);
    success = [fileManager fileExistsAtPath:path];
    if (success) {
        success = [fileManager removeItemAtPath:path error:&error];
    }
    //写入文件
    [UIImageJPEGRepresentation(image, 1.0f) writeToFile:path atomically:YES];
    return path;
}
@end

