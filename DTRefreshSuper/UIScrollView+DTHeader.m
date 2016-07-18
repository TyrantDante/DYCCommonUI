//
//  UIScrollView+DTRefresh.m
//  DTRefresh
//
//  Created by Dante on 16/7/12.
//  Copyright © 2016年 Dante. All rights reserved.
//

#import "UIScrollView+DTHeader.h"
#import "DTHeader.h"
#import <objc/runtime.h>

static const char DTHeaderKey = '\0';
@implementation UIScrollView (DTHeader)

- (void)setDt_header:(DTHeader *)dt_header{
    if (dt_header != self.dt_header) {
        //remove the old header
        [self.dt_header removeFromSuperview];
        [self insertSubview:dt_header atIndex:0];
        //store the new header
        [self willChangeValueForKey:@"dt_header"];
        objc_setAssociatedObject(self, &DTHeaderKey, dt_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"dt_header"];
    }
}

- (DTHeader *)dt_header{
    return objc_getAssociatedObject(self, &DTHeaderKey);
}
@end
