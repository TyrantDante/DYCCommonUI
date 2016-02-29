//
//  DYCBigEvaHeartView.h
//  DYCCommonUI
//
//  Created by NaXing on 16/2/26.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ScoreOfViewBlock)(NSInteger score);

@interface DYCBigEvaHeartView : UIView
//default is 5,
@property (nonatomic,assign) NSInteger numOfItem;
//default is emptyheart.png
@property (nonatomic,strong) UIImage *normalImage;
//default is heart.png
@property (nonatomic,strong) UIImage *selectedImage;

@property (nonatomic,copy) ScoreOfViewBlock scoreBlock;
@end
