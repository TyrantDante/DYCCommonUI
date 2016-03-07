//
//  TouchImageView.h
//  CommonUI
//
//  Created by NaXing on 16/2/18.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchImageView : UIImageView
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) NSInteger column;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign,readonly) BOOL select;
- (void)touch;
- (void)setSelect:(BOOL)select;
@end
