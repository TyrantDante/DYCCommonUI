//
//  DYCEvaluationPopUp.m
//  DYCCommonUI
//
//  Created by Dante on 16/2/29.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCEvaluationPopUp.h"
#import "DYCTextView.h"
#import "DYCBigEvaHeartView.h"
#define TITLE_FONT      [UIFont systemFontOfSize:16]
#define SUB_FONT        [UIFont systemFontOfSize:13]
#define TITLE_COLOR     [UIColor colorWithRed:0x36/255.0 green:0x36/255.0 blue:0x36/255.0 alpha:1]
#define SUB_COLOR       [UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1]
#define SUB_LINECOLOR   [UIColor colorWithRed:0xee/255.0 green:0xee/255.0 blue:0xee/255.0 alpha:1]
#define SUBMITBTN_COLOR [UIColor colorWithRed:0xf2/255.0 green:0x43/255.0 blue:0x46/255.0 alpha:1]
@interface DYCEvaluationPopUp()
@property (nonatomic,strong) DYCBigEvaHeartView *toJSEvaView;
@property (nonatomic,strong) DYCBigEvaHeartView *toGWEvaView;
@property (nonatomic,strong) DYCTextView *toJSTextView;
@property (nonatomic,strong) DYCTextView *toGWTextView;

@property (nonatomic,strong) NSString *toJSExp;
@property (nonatomic,strong) NSString *toGWExp;
@property (nonatomic,assign) NSInteger toJSScore;
@property (nonatomic,assign) NSInteger toGWScore;
@end
@implementation DYCEvaluationPopUp
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        _toJSEvaView = [[DYCBigEvaHeartView alloc] init];
        _toJSEvaView.numOfItem = 5;
        _toJSEvaView.scoreBlock = ^(NSInteger score){
            _toJSScore = score;
        };
        [self addSubview:_toJSEvaView];
        
        _toJSTextView = [[DYCTextView alloc] init];
        _toJSTextView.placeHolder = @"你想说的话……";
        _toJSTextView.font = [UIFont systemFontOfSize:13];
        _toJSTextView.clipsToBounds = YES;
        _toJSTextView.layer.cornerRadius = 4;
        _toJSTextView.layer.borderColor = [UIColor colorWithRed:0xd1/255.0 green:0xd1/255.0 blue:0xd1/255.0 alpha:1].CGColor;
        _toJSTextView.layer.borderWidth = 1;
        _toJSTextView.textBlock = ^(NSString *text){
            _toJSExp = text;
        };
        [self addSubview:_toJSTextView];
        
        _toGWEvaView = [[DYCBigEvaHeartView alloc] init];
        _toGWEvaView.numOfItem = 5;
        _toGWEvaView.scoreBlock = ^(NSInteger score){
            _toGWScore = score;
        };
        [self addSubview:_toGWEvaView];
        
        _toGWTextView = [[DYCTextView alloc] init];
        _toGWTextView.placeHolder = @"你想说的话……";
        _toGWTextView.font = [UIFont systemFontOfSize:13];
        _toGWTextView.clipsToBounds = YES;
        _toGWTextView.layer.cornerRadius = 4;
        _toGWTextView.layer.borderColor = [UIColor colorWithRed:0xd1/255.0 green:0xd1/255.0 blue:0xd1/255.0 alpha:1].CGColor;
        _toGWTextView.layer.borderWidth = 1;
        _toGWTextView.textBlock = ^(NSString *text){
            _toGWExp = text;
        };
        [self addSubview:_toGWTextView];
        
        UILabel *titleLabel = [DYCEvaluationPopUp labelWithFont:TITLE_FONT text:@"您的评价，让我们做的更好" textColor:TITLE_COLOR];
        titleLabel.tag = 10001;
        [self addSubview:titleLabel];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.tag = 1004;
        line.backgroundColor = SUB_LINECOLOR;
        [self addSubview:line];
        
        UILabel *subJSLabel = [DYCEvaluationPopUp labelWithFont:SUB_FONT text:@"对老师" textColor:SUB_COLOR];
        subJSLabel.tag = 1002;
        [self addSubview:subJSLabel];
        
        UIImageView *line1 = [[UIImageView alloc] init];
        line1.tag = 1005;
        line1.backgroundColor = SUB_LINECOLOR;
        [self addSubview:line1];
        
        UILabel *subGWLabel = [DYCEvaluationPopUp labelWithFont:SUB_FONT text:@"对顾问" textColor:SUB_COLOR];
        subGWLabel.tag = 1003;
        [self addSubview:subGWLabel];
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.backgroundColor = SUBMITBTN_COLOR;
        submitBtn.layer.cornerRadius = 5;
        submitBtn.clipsToBounds = YES;
        [submitBtn setTitle:@"提交评价" forState:UIControlStateNormal];
        submitBtn.tag = 1006;
        [self addSubview:submitBtn];
    }
    return self;
}

+ (UILabel *)labelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    UILabel *titleLabel = [self viewWithTag:10001];
    titleLabel.frame = CGRectMake(0, 25, self.frame.size.width, 16);
    
    UILabel *subJSLabel = [self viewWithTag:1002];
    subJSLabel.frame = CGRectMake(139, 66, width - 139 *2, 14);

    UIImageView *line = [self viewWithTag:1004];
    line.frame = CGRectMake(0, 74, width, 1);
    
    _toJSEvaView.frame = CGRectMake((width - 200) / 2.0, 100, 200, 25);
    _toJSTextView.frame = CGRectMake(40, 150, width - 80, 78);
    
    UILabel *subGWLabel = [self viewWithTag:1003];
    subGWLabel.frame = CGRectMake(139, 246, width - 139 * 2, 14);
    
    UIImageView *line1 = [self viewWithTag:1005];
    line1.frame = CGRectMake(0, 253, width, 1);
    
    _toGWEvaView.frame = CGRectMake((width - 200)/2.0, 283, 200, 25);
    _toGWTextView.frame = CGRectMake(40, 333, width - 80, 78);
    
    UIButton *submitBtn = [self viewWithTag:1006];
    submitBtn.frame = CGRectMake(40, height - 64, width - 80, 44);
}

- (void)submitBtnClicked:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(popUp:toJSExp:toGWExp:toJSScore:toGWScore:)]) {
        [_delegate popUp:self toJSExp:_toJSExp toGWExp:_toGWExp toJSScore:_toJSScore toGWScore:_toGWScore];
    }
    [self hide];
}

- (void)showInView:(UIView *)view{
    UIView *bgView = [[UIView alloc] initWithFrame:view.bounds];
    [view addSubview:bgView];
    __block CGRect frame = self.frame;
    self.frame = CGRectZero;
    [bgView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.frame = frame;
    }];
    
}

- (void)hide{
    CGRect frame = self.frame;
    [UIView animateWithDuration:0.5 animations:^{
        self.superview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.frame = CGRectZero;
    }];
    [self.superview removeFromSuperview];
    [self removeFromSuperview];
    self.frame = frame;
}
@end
