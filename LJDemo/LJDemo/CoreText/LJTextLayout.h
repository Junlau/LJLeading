//
//  LJTextLayout.h
//  LJDemo
//
//  Created by lj on 2017/3/29.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LJTextLayout : CALayer

//是否异步绘制开关，默认NO
@property (nonatomic, assign) BOOL displaysAsynchronously;
@end
