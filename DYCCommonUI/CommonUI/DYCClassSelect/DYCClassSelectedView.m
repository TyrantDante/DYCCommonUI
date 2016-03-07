//
//  DYCClassSelectedView.m
//  CommonUI
//
//  Created by NaXing on 16/2/18.
//  Copyright © 2016年 暴君. All rights reserved.
//
#import "TouchImageView.h"
#import "DYCClassSelectedView.h"
@interface DYCClassSelectedView()
@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGFloat rowHeight;
@property (nonatomic,assign) CGFloat columnWidth;
@property (nonatomic,strong) NSArray *rowLines;
@property (nonatomic,strong) NSArray *columnLines;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) NSInteger column;
@end
@implementation DYCClassSelectedView

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
        _column = 1;
        _row = 1;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0f;
        _canSlidToSelect = NO;
    }
    return self;
}
- (void)setCanSlidToSelect:(BOOL)canSlidToSelect{
    _canSlidToSelect = canSlidToSelect;
    if (canSlidToSelect) {
        self.scrollEnabled = NO;
    }
}
- (void)setDelegate:(id<DYCClassSelectedViewDelegate>)delegate{
    _classDelegate = delegate;
    [self createSubViews];
}

- (void)createSubViews{
    if ([_classDelegate respondsToSelector:@selector(rowInSelectView:)]) {
        self.row = [_classDelegate rowInSelectView:self];
    }
    if ([_classDelegate respondsToSelector:@selector(columnInSelectView:)]) {
        self.column = [_classDelegate columnInSelectView:self];
    }
    for (int i = 0; i < _row; i ++) {
        for (int j = 0 ; j < _column ; j ++) {
            if ([_classDelegate respondsToSelector:@selector(statusAtRow:column:selectView:)]) {
                BOOL status = [_classDelegate statusAtRow:i column:j selectView:self];
                TouchImageView *touchView = [[TouchImageView alloc] init];
                touchView.row = i;
                touchView.column = j;
                touchView.width = _columnWidth;
                touchView.height = _rowHeight;
                touchView.tag = i * 1000 + j + 10000;
                [self addSubview:touchView];
                if (status) {
                    [touchView touch];
                }
            }
        }
    }
}

- (void)setRow:(NSInteger)row{
    if (row <= 0) {
        NSLog(@"行数不能小于1");
        return;
    }
    _row = row;
    if (self.contentSize.height ){
        _rowHeight = self.frame.size.height / _row;
        return;
    }
    _rowHeight = 0.0f;
}

- (void)setColumn:(NSInteger)column{
    if (column <=0) {
        NSLog(@"列数不能小于1");
        return;
    }
    _column = column;
    if (self.contentSize.width) {
        _columnWidth = self.contentSize.width / _column;
        return;
    }
    _columnWidth = 0.0f;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (CGSizeEqualToSize(CGSizeZero, self.contentSize)) {
        [self setContentSize:frame.size];
    }
    _columnWidth = self.frame.size.width / _column;
    _rowHeight = self.frame.size.height / _row;
}

- (void)setContentSize:(CGSize)contentSize{
    [super setContentSize:contentSize];
    _columnWidth = contentSize.width / _column;
    _rowHeight = contentSize.height / _row;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (CGRectIsEmpty(self.frame)) {
        return;
    }
    UITouch *startTouch = [touches anyObject];
    _startPoint = [startTouch locationInView:self];
    
    if (!_columnWidth) {
        return;
    }
    NSInteger touchColumn = ceil(_startPoint.x / _columnWidth) - 1;
    if (!_rowHeight) {
        return;
    }
    NSInteger touchRow = ceil(_startPoint.y / _rowHeight) - 1;
    
    NSInteger tag = touchRow * 1000 + touchColumn + 10000;
    
    TouchImageView *touchView = [self viewWithTag:tag];
    if (!touchView) {
        touchView = [[TouchImageView alloc] init];
        touchView.row = touchRow;
        touchView.column = touchColumn;
        touchView.width = _columnWidth;
        touchView.height = _rowHeight;
        touchView.tag = tag;
        [self addSubview:touchView];
    }
    [touchView touch];
    if ([_classDelegate respondsToSelector:@selector(didSelectAtRow:column:status:)]) {
        [_classDelegate didSelectAtRow:touchRow column:touchColumn status:touchView.select];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (CGRectIsEmpty(self.frame)) {
        return;
    }
    if (!_canSlidToSelect) {
        return;
    }
    UITouch *moveTouch = [touches anyObject];
    CGPoint movePoint = [moveTouch locationInView:self];

    BOOL isSame = [self locationPoint1:movePoint equelToPoint2:_startPoint];
    if (isSame) {
        return;
    }
    
    _startPoint = movePoint;
    if (!_columnWidth) {
        return;
    }
    
    NSInteger touchColumn = ceil(_startPoint.x / _columnWidth) - 1;
    if (!_rowHeight) {
        return;
    }
    NSInteger touchRow = ceil(_startPoint.y / _rowHeight) - 1;
    
    NSInteger tag = touchRow * 1000 + touchColumn + 10000;
    
    TouchImageView *touchView = [self viewWithTag:tag];
    if (!touchView) {
        touchView = [[TouchImageView alloc] init];
        touchView.row = touchRow;
        touchView.column = touchColumn;
        touchView.width = _columnWidth;
        touchView.height = _rowHeight;
        touchView.tag = tag;
        [self addSubview:touchView];
    }
    [touchView touch];
}

- (BOOL)locationPoint1:(CGPoint)point1 equelToPoint2:(CGPoint)point2{
    NSInteger row1 = ceil(point1.y / _rowHeight);
    NSInteger row2 = ceil(point2.y / _rowHeight);
    NSInteger column1 = ceil(point1.x / _columnWidth);
    NSInteger column2 = ceil(point2.x / _columnWidth);
    if ((row1 == row2) && (column1 == column2)) {
        return YES;
    }
    return NO;
}
- (void)setSelect:(BOOL)select byRow:(NSInteger)row {
    for (int i = 0; i < _column; i ++) {
        NSInteger tag = row * 1000 + i + 10000;
        TouchImageView *touchView = [self viewWithTag:tag];
        [touchView setSelect:select];
    }
}
- (void)setSelect:(BOOL)select byColumn:(NSInteger)column{
    for (int i = 0; i < _row; i ++) {
        NSInteger tag = i * 1000 + column + 10000;
        TouchImageView *touchView = [self viewWithTag:tag];
        [touchView setSelect:select];
    }
}
@end
