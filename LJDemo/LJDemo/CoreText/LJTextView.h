//
//  LJTextView.h
//  LJDemo
//
//  Created by lj on 2017/3/16.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJTextView : UIView

@property (nonatomic, strong) NSMutableAttributedString *textString;
@property (nonatomic, assign) BOOL displaysAsynchronously;

- (void)drawTextAndImage:(CGContextRef)context size:(CGSize)size;
@end
