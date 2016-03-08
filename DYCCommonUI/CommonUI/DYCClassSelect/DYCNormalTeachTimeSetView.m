//
//  DYCNormalTeachTimeSetView.m
//  DYCCommonUI
//
//  Created by Dante on 16/3/7.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCNormalTeachTimeSetView.h"
#import "DYCClassSelectedView.h"
#import "DYCWeekView.h"
#import "DYCClockView.h"
#import "DYCClassShowDifView.h"
#define COLUMN_NUM  7
#define ROW_NUM     13
#define UIColorWithRGB(r, g, b)  [UIColor colorWithRed:(r)/255.f  green:(g)/255.f blue:(b)/255.f alpha:1.f]

@interface DYCNormalTeachTimeSetView()<DYCClassSelectedViewDelegate,DYCWeekViewDelegate,DYCClockViewDelegate>
@property (nonatomic,strong) DYCClassSelectedView *classSelView;
@property (nonatomic,strong) DYCWeekView *weekView;
@property (nonatomic,strong) DYCClockView *clockView;
@property (nonatomic,strong) DYCClassShowDifView *difView;
@end
@implementation DYCNormalTeachTimeSetView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorWithRGB(0xf5, 0xf5, 0xf5);
        _clockView = [[DYCClockView alloc] init];
        _clockView.delegate = self;
        _clockView.startClock = 8;
        _clockView.endClock = 21;
        
        _classSelView = [[DYCClassSelectedView alloc] init];
        _classSelView.classDelegate = self;
        [self addSubview:_classSelView];
        [_classSelView addSubview:_clockView];
        
        _weekView = [[DYCWeekView alloc] init];
        _weekView.delegate = self;
        [self addSubview:_weekView];
        
        _difView = [[DYCClassShowDifView alloc] init];
        [self addSubview:_difView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _weekView.frame = CGRectMake(20, 0, self.frame.size.width - 20, 40);
    CGFloat cellWidth = (self.frame.size.width - 20) / COLUMN_NUM;
    _classSelView.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 60);
    _classSelView.contentSize = CGSizeMake(cellWidth * COLUMN_NUM, cellWidth * ROW_NUM);
    _clockView.frame = CGRectMake(-20, 0, 20, cellWidth * ROW_NUM);
    _difView.frame = CGRectMake(self.frame.size.width - 160, CGRectGetMaxY(_classSelView.frame), 160, 20);
}

- (void)clockView:(DYCClockView *)clockView didSelectAtIndex:(NSInteger)index{
    [_classSelView setSelect:YES byRow:index];
}
- (void)clockView:(DYCClockView *)clockView didDeselectAtIndex:(NSInteger)index{
    [_classSelView setSelect:NO byRow:index];
}
- (void)weekView:(DYCWeekView *)weekView didSelectAtIndex:(NSInteger)index{
    [_classSelView setSelect:YES byColumn:index];
}

- (void)weekView:(DYCWeekView *)weekView didDeselectAtIndex:(NSInteger)index{
    [_classSelView setSelect:NO byColumn:index];
}

- (NSInteger)rowInSelectView:(DYCClassSelectedView *)selectView{
    _clockView.rowNum = ROW_NUM;
    return ROW_NUM;
}

- (NSInteger)columnInSelectView:(DYCClassSelectedView *)selectView{
    return COLUMN_NUM;
}

- (BOOL)statusAtRow:(NSInteger)row column:(NSInteger)column selectView:(DYCClassSelectedView *)selectView{
    return NO;
}

- (void)didSelectAtRow:(NSInteger)row column:(NSInteger)column status:(BOOL)staus{
    
}

@end

