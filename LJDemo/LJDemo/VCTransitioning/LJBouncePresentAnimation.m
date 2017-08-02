//
//  LJBouncePresentAnimation.m
//  LJDemo
//
//  Created by lj on 2017/4/26.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJBouncePresentAnimation.h"

@implementation LJBouncePresentAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    //从右到左
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, screenBounds.size.width, 0);
    
    [[transitionContext containerView]addSubview:toVC.view];
    
    NSTimeInterval time = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:time animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
    //从下到上
//    //最终位置
//    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
//    //初始位置
//    toVC.view.frame = CGRectOffset(toVC.view.frame, 0, screenBounds.size.height);
//    
//    //Add toVC's view to containerView
//    [[transitionContext containerView]addSubview:toVC.view];
//    
//    //动画
//    NSTimeInterval time = [self transitionDuration:transitionContext];
//    
//    [UIView animateWithDuration:time
//                          delay:0.0
//         usingSpringWithDamping:0.6
//          initialSpringVelocity:0.0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         toVC.view.frame = finalFrame;
//                     } completion:^(BOOL finished) {
//                         //Tell context that we completed.
//                         [transitionContext completeTransition:YES];
//                     }];
}


@end
