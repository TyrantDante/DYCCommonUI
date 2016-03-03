//
//  TouchImageView.m
//  CommonUI
//
//  Created by NaXing on 16/2/18.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "TouchImageView.h"
#define NORMALCOLOR [UIColor whiteColor]
#define SELECTCOLOR [UIColor redColor]
@interface TouchImageView()
@property (nonatomic,assign) BOOL select;
@end
@implementation TouchImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    self = [super init];
    if (self) {
        self.select = NO;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5f;
    }
    return self;
}

- (void)touch{
    self.select = !_select;
}

- (void)setSelect:(BOOL)select{
    if (select == NO) {
        self.backgroundColor = NORMALCOLOR;
    } else {
        self.backgroundColor = SELECTCOLOR;
    }
    _select = select;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
//    __block CGRect frame = self.frame;
//    CGRect handlerFrame = self.frame;
//    handlerFrame.size = CGSizeZero;
//    self.frame = handlerFrame;
    
    [UIView animateWithDuration:0.5 animations:^{
        [super setBackgroundColor:backgroundColor];

//        self.frame = frame;
    }];
}

- (void)setRow:(NSInteger)row{
    _row = row;
    [self reloadFrame];
}

- (void)setColumn:(NSInteger)column{
    _column = column;
    [self reloadFrame];
}

- (void)setWidth:(CGFloat)width{
    _width = width;
    [self reloadFrame];
}

- (void)setHeight:(CGFloat)height{
    _height = height;
    [self reloadFrame];
}

- (void)reloadFrame{
    self.frame = CGRectMake((_column) * _width
                            , (_row) * _height
                            , _width
                            , _height);
}
@end