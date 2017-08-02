//
//  SwipeLeftInteractiveTransition.m
//  LJDemo
//
//  Created by lj on 2017/4/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "SwipeLeftInteractiveTransition.h"

@interface SwipeLeftInteractiveTransition()
@property(assign, nonatomic) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;
@end

@implementation SwipeLeftInteractiveTransition

- (void)wirePanToViewController:(UIViewController *)viewController {
    self.presentingVC = viewController;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [viewController.view addGestureRecognizer:pan];
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x < 0) {
        switch (gestureRecognizer.state) {
            case UIGestureRecognizerStateBegan:
            {
                self.interacting = YES;
                if (self.dismissVC) {
                    [self.presentingVC presentViewController:self.dismissVC animated:YES completion:nil];
                }

            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                CGFloat fraction = -translation.x/[UIScreen mainScreen].bounds.size.width;
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                self.shouldComplete = (fraction > 0.3);
                [self updateInteractiveTransition:fraction];
            }
                break;
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded:
            {
                self.interacting = NO;
                if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                    [self cancelInteractiveTransition];
                } else {
                    [self finishInteractiveTransition];
                }
            }
                break;
            default:
                break;
        }
    }
    
}

@end
