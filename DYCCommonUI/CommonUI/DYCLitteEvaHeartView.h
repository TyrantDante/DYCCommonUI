//
//  DYCLitteEvaHeartView.h
//  DYCCommonUI
//
//  Created by NaXing on 16/2/26.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYCLitteEvaHeartView : UIView

//default is heart.png
@property (nonatomic,strong) UIImage *selectImage;
//default is head_empty.png
@property (nonatomic,strong) UIImage *normalImage;

- (instancetype)initWithTotalScroe:(NSInteger)totalScore curScore:(NSInteger)curScore;
@end
