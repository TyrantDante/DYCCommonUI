//
//  DYCCarouselView.h
//  DYCCommonUI
//
//  Created by Dante on 16/3/9.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYCCarouselView;
@protocol DYCCarouselViewDelegate<NSObject>
- (UIView *)carouselView:(DYCCarouselView *)carouselView currentView:(UIView *)currentView;
- (UIView *)carouselView:(DYCCarouselView *)carouselView lastView:(UIView *)lastView;
- (UIView *)carouselView:(DYCCarouselView *)carouselView nextView:(UIView *)nextView;
@end
@interface DYCCarouselView : UIView
@property (nonatomic,assign) id<DYCCarouselViewDelegate> delegate;
@end
