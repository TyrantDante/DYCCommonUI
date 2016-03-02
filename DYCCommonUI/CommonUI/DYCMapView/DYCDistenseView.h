//
//  DYCDistenseView.h
//  DYCDemo
//
//  Created by NaXing on 16/1/21.
//  Copyright © 2016年 NX_JEH. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DYCDistenseViewDelegate<NSObject>
- (void)didSelectDistanceFloat:(CGFloat)distance;
@end
@interface DYCDistenseView : UIPickerView
@property (nonatomic,assign) NSInteger minDist;
@property (nonatomic,assign) NSInteger maxDist;
@property (nonatomic,assign) id<DYCDistenseViewDelegate> distDelegate;
- (void)show;
- (void)hide;
@end
