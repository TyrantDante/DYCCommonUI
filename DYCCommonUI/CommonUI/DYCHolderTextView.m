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
//    UILabel *strLabel = [self strLengthLabel];
//    strLabel.frame = CGRectMake(self.frame.size.width - 100, self.frame.size.height - 8, 98, 8);
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

- (void)textViewDidChange:(UITextView *)textView{
    if (_maxLength == 0) {
        _maxLength = 100;
    }
    if (textView.text.length > _maxLength) {
        NSString *str = [textView.text substringWithRange:NSMakeRange(0, _maxLength)];
        textView.text = str;
    }
    
    UILabel *strLabel =[self strLengthLabel];
    NSAttributedString *attrStr = [self attrStrByCurLength:textView.text.length];
    strLabel.attributedText = attrStr;
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

- (NSAttributedString *)attrStrByCurLength:(NSInteger)curLength{
    if (_maxLength == 0) {
        _maxLength = 100;
    }
    UIColor *firstColor = [UIColor lightGrayColor];
    if (curLength >= _maxLength) {
        firstColor = [UIColor redColor];
    }
    NSString *firstStr = [NSString stringWithFormat:@"%3.0ld",(unsigned long)curLength];
    NSString *secStr = [NSString stringWithFormat:@"/%ld",(unsigned long)_maxLength];
    NSString *totalStr = [firstStr stringByAppendingString:secStr];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    NSDictionary *firstDict = @{NSForegroundColorAttributeName:firstColor,NSFontAttributeName:[UIFont systemFontOfSize:8]};
    NSDictionary *secDict = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:8]};
    [attrStr addAttributes:firstDict range:[totalStr rangeOfString:firstStr]];
    [attrStr addAttributes:secDict range:[totalStr rangeOfString:secStr]];
    return attrStr;
}

- (UILabel *)strLengthLabel{
    UILabel *strLengthLabel = [self viewWithTag:1002];
    if (!strLengthLabel) {
        strLengthLabel = [[UILabel alloc] init];
        strLengthLabel.textAlignment = NSTextAlignmentRight;
        [self insertSubview:strLengthLabel atIndex:0];
        strLengthLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        strLengthLabel.tag = 1002;
        strLengthLabel.textColor = [UIColor colorWithRed:0xd8/255.0 green:0xd8/255.0 blue:0xd8/255.0 alpha:1];
    }
    return strLengthLabel;
}

- (void)setContentOffset:(CGPoint)contentOffset{
    [super setContentOffset:contentOffset];
//    UILabel *strLabel = [self strLengthLabel];
//    
//    CGRect frame = strLabel.frame;
//    frame.origin.y = self.contentSize.height - 10;
//    strLabel.frame = frame;
}

- (void)setContentSize:(CGSize)contentSize{
    [super setContentSize:contentSize];
    UILabel *strLabel = [self strLengthLabel];

    CGRect frame = strLabel.frame;
    if(contentSize.height < self.frame.size.height){
        frame.origin.y = self.frame.size.height - 10;
    } else {
        frame.origin.y = self.contentSize.height - 10;
    }
    frame.origin.x = self.contentSize.width - 100;
    frame.size.width = 98;
    frame.size.height = 10;
    strLabel.frame = frame;
}

@end
