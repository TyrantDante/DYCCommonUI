//
//  DYCMapView.h
//  DYCDemo
//
//  Created by NaXing on 15/12/3.
//  Copyright © 2015年 NX_JEH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYCMapView;
@class AMapPOI;
@protocol DYCMapViewDelegate<NSObject>
- (void)mapView:(DYCMapView *)mapView didSelectRow:(NSInteger)index aMapPoi:(AMapPOI *)poi;
@end

@interface DYCMapView : UIView
@property (nonatomic,assign) id<DYCMapViewDelegate> mapViewDelegate;
//开始定位
- (void)startLocation;
//停止定位
- (void)stopLocation;

- (void)clearMapView;
- (void)clearSearch;

- (instancetype)initWithFrame:(CGRect)frame ApiKey:(NSString *)apiKey;
@end

