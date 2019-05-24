//
//  LJPathView.m
//  LJDemo
//
//  Created by lj on 2018/6/26.
//  Copyright © 2018年 LJ. All rights reserved.
//

#import "LJPathView.h"

@implementation LJPathView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.pointX = self.frame.size.width/2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(self.pointX , 1)];
    [path addLineToPoint:CGPointMake(self.pointX - 6, 6)];
//    [path addLineToPoint:CGPointMake(1, 6)];//拐点
    [path addLineToPoint:CGPointMake(11, 6)];//拐点
    [path addQuadCurveToPoint:CGPointMake(1, 16) controlPoint:CGPointMake(1, 6)];
    [path addLineToPoint:CGPointMake(1, self.frame.size.height - 1)];//拐点
    [path addLineToPoint:CGPointMake(self.frame.size.width - 1, self.frame.size.height - 1)];//拐点
    [path addLineToPoint:CGPointMake(self.frame.size.width - 1, 6)];//拐点
    [path addLineToPoint:CGPointMake(self.pointX + 6, 6)];
    [path addLineToPoint:CGPointMake(self.pointX , 1)];
    
    path.lineWidth = 1;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    
    [[UIColor blueColor] setStroke];
    [[UIColor redColor] setFill];
    // 描边和填充
    [path stroke];//描边
    [path fill];//填充
}

@end
