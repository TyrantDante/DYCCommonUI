//
//  DYCMapDistanceView.h
//  DYCDemo
//
//  Created by NaXing on 15/12/4.
//  Copyright © 2015年 NX_JEH. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DYCMapDistanceViewDelegate<NSObject>


@end
@interface DYCMapDistanceView : UIView
@property (nonatomic,assign) id<DYCMapDistanceViewDelegate> mapDistanceDelegate;

//开始定位
- (void)startLocation;
//停止定位
- (void)stopLocation;

- (void)clearMapView;
- (void)clearSearch;

- (instancetype)initWithFrame:(CGRect)frame ApiKey:(NSString *)apiKey;
- (void)setDistance:(CGFloat)distance;
@end
