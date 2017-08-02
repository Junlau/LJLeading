//
//  NormalDismissAnimation.m
//  LJDemo
//
//  Created by lj on 2017/4/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "NormalDismissAnimation.h"

@implementation NormalDismissAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *formVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect initFrame = [transitionContext initialFrameForViewController:formVC];
    CGRect finalFrame = CGRectOffset(initFrame, [UIScreen mainScreen].bounds.size.width, 0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        formVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
