//
//  DYCTextView.h
//  DYCCommonUI
//
//  Created by Dante on 16/2/29.
//  Copyright © 2016年 暴君. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^textOfViewBlock)(NSString *text);
@interface DYCHolderTextView : UITextView<UITextViewDelegate>
@property (nonatomic,strong) NSString *placeHolder;
@property (nonatomic,assign) NSInteger maxLength;
@property (nonatomic,copy) textOfViewBlock textBlock;
@end
