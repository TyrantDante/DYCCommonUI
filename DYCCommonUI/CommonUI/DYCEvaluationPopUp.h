//
//  DYCEvaluationPopUp.h
//  DYCCommonUI
//
//  Created by Dante on 16/2/29.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYCEvaluationPopUp;
@protocol DYCEvaluationPopUpDelegate<NSObject>
- (void)popUp:(DYCEvaluationPopUp *)popUp toJSExp:(NSString *)tojsExp toGWExp:(NSString *)togwExp toJSScore:(NSInteger)jsScore toGWScore:(NSInteger)gwScore;
@end
@interface DYCEvaluationPopUp : UIView
@property (nonatomic,assign) id<DYCEvaluationPopUpDelegate> delegate;
- (void)showInView:(UIView *)view;
@end
