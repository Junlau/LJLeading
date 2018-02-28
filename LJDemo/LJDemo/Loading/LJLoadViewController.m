//
//  LJLoadViewController.m
//  LJDemo
//
//  Created by lj on 2017/8/4.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJLoadViewController.h"

@interface LJLoadViewController ()
@property (nonatomic, strong)CAShapeLayer *shapeLayer;
@end

@implementation LJLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Loading";

    self.shapeLayer.frame = CGRectMake((self.view.frame.size.width - 50)/2, 100, 50, 50);
    [self.view.layer addSublayer:self.shapeLayer];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"Change" forState:UIControlStateNormal];
    button.center = self.view.center;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(changeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeButtonPressed {
//    self.shapeLayer.strokeEnd = self.shapeLayer.strokeEnd + 0.1;
//    [self.shapeLayer setNeedsDisplay];
    [self startLoadingAnimation];
}

- (void)startLoadingAnimation {
//    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    strokeStartAnimation.fromValue = [NSNumber numberWithInt:-1];
//    strokeStartAnimation.toValue = [NSNumber numberWithInt:1];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    strokeEndAnimation.fromValue = [NSNumber numberWithInt:0];
    strokeEndAnimation.toValue = [NSNumber numberWithFloat:0.6];
    strokeEndAnimation.duration = 1.0;
    strokeEndAnimation.repeatCount = 1;
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    [self.shapeLayer addAnimation:strokeEndAnimation forKey:@"EndAnimation"];
    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.duration = 2.0;
//    group.repeatCount = 1;
//    group.animations = @[strokeStartAnimation, strokeEndAnimation];
//    [self.shapeLayer addAnimation:group forKey:@"loading"];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:(-M_PI/2)];
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    rotateAnimation.repeatCount = 1;
    rotateAnimation.duration = 1.0;
    rotateAnimation.beginTime = CACurrentMediaTime() + 1.0;
    [self.shapeLayer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
    
    CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation2.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation2.toValue = [NSNumber numberWithFloat:M_PI * 2];
    rotateAnimation2.repeatCount = MAXFLOAT;
    rotateAnimation2.duration = 1;
    rotateAnimation2.beginTime = CACurrentMediaTime() + 2.0;
    [self.shapeLayer addAnimation:rotateAnimation2 forKey:@"rotateAnimation2"];
}

- (void)stopLoadingAnimation {
    [self.shapeLayer removeAllAnimations];
}

- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer == nil) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.lineJoin = kCALineJoinRound;
        _shapeLayer.lineWidth = 2.0;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.strokeEnd = 0;
        _shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 50, 50)].CGPath;
        [_shapeLayer setAffineTransform:CGAffineTransformMakeRotation(-M_PI/2)];
    }
    return _shapeLayer;
}

@end
