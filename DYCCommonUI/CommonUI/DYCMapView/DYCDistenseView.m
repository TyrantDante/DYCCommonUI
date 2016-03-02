//
//  DYCDistenseView.m
//  DYCDemo
//
//  Created by NaXing on 16/1/21.
//  Copyright © 2016年 NX_JEH. All rights reserved.
//

#import "DYCDistenseView.h"
@interface DYCDistenseView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,assign) BOOL isMax;
@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,strong) UIButton *hideBtn;
@end
@implementation DYCDistenseView

- (instancetype)init{
    self =[super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
}
- (void)hideBtnClicked:(id)sender{
    [self hide];
}

- (void)show{
    UIView *midView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    midView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
    if (!_hideBtn) {
        _hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hideBtn.backgroundColor = [UIColor whiteColor];
        _hideBtn.frame = CGRectMake(0, midView.frame.size.height - 200 - 44, midView.frame.size.width, 44);
        [_hideBtn setTitle:@"确定    " forState:UIControlStateNormal];
        _hideBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_hideBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_hideBtn addTarget:self action:@selector(hideBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [midView addSubview:_hideBtn];
    [self.superview addSubview:midView];
    [self removeFromSuperview];
    [midView addSubview:self];
    self.hidden = NO;
}

- (void)hide{
    UIView *view = self.superview;
    [self removeFromSuperview];
    [view.superview addSubview:self];
    [view removeFromSuperview];
    self.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count = 0;
    switch (component) {
        case 0:
            count = _maxDist - _minDist + 1;
            break;
        case 1:
            count = 1;
            break;
        case 2:
            if (_isMax) {
                count = 1;
            } else {
                count = 10;
            }
            break;
        case 3:
            count = 1;
            break;
        default:
            break;
    }
    return count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = @"";
    switch (component) {
        case 0:
            title = [NSString stringWithFormat:@"%ld",_minDist + row];
            break;
        case 1:
            title = @".";
            break;
        case 2:
            title = [NSString stringWithFormat:@"%ld",row];
            break;
        case 3:
            title = @"KM (千米)";
            break;
        default:
            break;
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        NSInteger maxRow = _maxDist - _minDist;
        if (row == maxRow) {
            _isMax = YES;
            [self reloadComponent:2];
            [self selectRow:0 inComponent:2 animated:YES];
        } else {
            _isMax = NO;
            [self reloadComponent:2];
            [self selectRow:0 inComponent:2 animated:YES];
        }
        _distance = row + _minDist;
        return;
    }
    if (component == 2) {
        _distance = (int)_distance + row * 0.1;
    }
    if ([_distDelegate respondsToSelector:@selector(didSelectDistanceFloat:)]) {
        [_distDelegate didSelectDistanceFloat:_distance];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont systemFontOfSize:14];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat width = 0.0;
    switch (component) {
        case 0:
            width = 40;
            break;
        case 1:
            width = 20;
            break;
        case 2:
            width = 40;
            break;
        case 3:
            width = 80;
        default:
            break;
    }
    return width;
}


@end
