//
//  DYCTextView.m
//  DYCCommonUI
//
//  Created by Dante on 16/2/29.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import "DYCHolderTextView.h"

@implementation DYCHolderTextView

- (void)layoutSubviews{
    [super layoutSubviews];
    UILabel *placeLabel = [self placeHolderLabel];
    CGFloat height = self.font.lineHeight;
    CGFloat width = self.frame.size.width;
    placeLabel.frame = CGRectMake(7, 7, width, height);
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.delegate = self;
    UILabel *placeLabel = [self placeHolderLabel];
    placeLabel.text = placeHolder;
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    UILabel *placeLabel = [self placeHolderLabel];
    placeLabel.font = font;
}

- (UILabel *)placeHolderLabel{
    UILabel *placeLabel = [self viewWithTag:1001];
    if (!placeLabel) {
        placeLabel = [[UILabel alloc] init];
        [self addSubview:placeLabel];
        placeLabel.enabled = NO;
        placeLabel.tag = 1001;
        placeLabel.textColor = [UIColor colorWithRed:0xd8/255.0 green:0xd8/255.0 blue:0xd8/255.0 alpha:1];
    }
    return placeLabel;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    UILabel *placeLabel = [self viewWithTag:1001];
    placeLabel.hidden = YES;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        UILabel *placeLabel = [self viewWithTag:1001];
        placeLabel.hidden = NO;
    }
    if (_textBlock) {
        _textBlock(textView.text);
    }
}
@end
