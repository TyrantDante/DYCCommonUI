//
//  DYCNormalTeachTimeSetView.m
//  DYCCommonUI
//
//  Created by Dante on 16/3/7.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCNormalTeachTimeSetView.h"
#import "DYCClassSelectedView.h"
@interface DYCNormalTeachTimeSetView()<DYCClassSelectedViewDelegate>
@property (nonatomic,strong) DYCClassSelectedView *classSelView;
@end
@implementation DYCNormalTeachTimeSetView
- (instancetype)init{
    self = [super init];
    if (self) {
        _classSelView = [[DYCClassSelectedView alloc] init];
        _classSelView.classDelegate = self;
        [self addSubview:_classSelView];
    }
    return self;
}


@end
