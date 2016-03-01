//
//  UIScrollView+DYC.m
//  DYCCommonUI
//
//  Created by Dante on 16/2/29.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "UIScrollView+DYC.h"
#import <objc/runtime.h>

@implementation UIScrollView (DYC)
static const char DYCHeaderKey = '\0';
static const char DYCOLDSIZEKEY = '1';
- (void)setDyc_header:(UIView *)dyc_header{
    if (self.dyc_header != dyc_header) {
        [self.dyc_header removeFromSuperview];
        [super insertSubview:dyc_header atIndex:0];
        // 存储新的
        [self willChangeValueForKey:@"dyc_header"]; // KVO
        objc_setAssociatedObject(self, &DYCHeaderKey,
                                 dyc_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"dyc_header"]; // KVO
        [self addObserver:self forKeyPath:@"contentOffset1" options:NSKeyValueObservingOptionNew context:nil];
//        [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [self setOldSize:NSStringFromCGSize(self.dyc_header.frame.size)];
        [self reframeSubViews];
//        CGAffineTransform transform = self.transform;
//        self.transform = CGAffineTransformTranslate(transform,0, self.header.bounds.size.height);
    }
}

- (void)setOldSize:(NSString *)oldSize{
    [self willChangeValueForKey:@"oldSize"]; // KVO
    objc_setAssociatedObject(self, &DYCOLDSIZEKEY,
                             oldSize, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"oldSize"];
}
- (NSString *)oldSize{
    return objc_getAssociatedObject(self, &DYCOLDSIZEKEY);
}
- (UIView *)dyc_header{
    return objc_getAssociatedObject(self, &DYCHeaderKey);
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset1"]) {
        if (object == self) {
            UINavigationController *currentVC = [self getCurrentVC];
            CGPoint point = self.contentOffset;
            CGSize oldSize = CGSizeFromString(self.oldSize);
            CGFloat deltaY = - point.y + oldSize.height;
            CGFloat delta = deltaY / oldSize.height;
            CGFloat deltaX = delta * oldSize.width ;
            CGRect newFrame = self.dyc_header.frame;
            if ((oldSize.width - deltaX) <= 0) {
                newFrame.origin.x = (oldSize.width - deltaX)/2.0;
                newFrame.size = CGSizeMake(deltaX, deltaY);
                newFrame.origin.y = point.y;
                currentVC.navigationBar.alpha = 0;
            }else{
                currentVC.navigationBar.alpha = (oldSize.height - deltaX + 64)/oldSize.height;
            }
            self.dyc_header.frame = newFrame;
            //        NSLog(@"frame (%f,%f,%f,%f)",newFrame.origin.x,newFrame.origin.y,deltaX,deltaY);
            
        }
        return;
    }
//    if ([keyPath isEqualToString:@"contentSize"]){
//        UIView *bgView = [self getBgView];
//        
//        CGRect newFrame = bgView.frame;
//        CGSize newContentSize = self.contentSize;
//        newContentSize.height += self.dyc_header.frame.size.height;
//        self.contentSize = newContentSize;
//        newFrame.size = newContentSize;
//        bgView.frame = newFrame;
//    }
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
//}

- (void)setContentFrame:(CGRect)frame{
    [self setContentSize:frame.size];
    CGRect newFrame = [self getBgView].frame;
    newFrame.size = frame.size;
    [self getBgView].frame = newFrame;
}

- (UIView *)getBgView{
    UIView *bgView = [self viewWithTag:99999];
    if (!bgView) {
        bgView = [[UIView alloc] init];
        bgView.tag = 99999;
        bgView.backgroundColor = [UIColor blackColor];
        [super addSubview:bgView];
    }

    return bgView;
//    return self;
}

- (void)addSubview:(UIView *)view{
    if (self.dyc_header == nil) {
        [super addSubview:view];
        return;
    }
    NSArray *array = view.subviews;
    UIView *bgView = [self getBgView];
    for (UIView *sview in array) {
        [sview removeFromSuperview];
        [bgView addSubview:sview];
    }
    
    [bgView addSubview:view];
}
- (void)reframeSubViews{
    for (UIView *view in self.dyc_header.subviews) {
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    }
    UIView *bgView = [self getBgView];
    CGRect newFrame = bgView.frame;
    newFrame.origin.y = self.dyc_header.frame.size.height;
    bgView.frame = newFrame;
    NSLog(@"%f",newFrame.origin.y);
}

- (UINavigationController *)getCurrentVC
{
    UINavigationController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UINavigationController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
