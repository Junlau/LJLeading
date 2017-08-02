//
//  SwipeUpInteractiveTransition.m
//  LJDemo
//
//  Created by lj on 2017/4/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "SwipeUpInteractiveTransition.h"
@interface SwipeUpInteractiveTransition()
@property(assign, nonatomic) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;
@end

@implementation SwipeUpInteractiveTransition

- (void)wirePanToViewController:(UIViewController *)viewController {
    self.presentingVC = viewController;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [viewController.view addGestureRecognizer:pan];
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
           // CGFloat fraction = translation.y/[UIScreen mainScreen].bounds.size.height;
            CGFloat fraction = translation.x/[UIScreen mainScreen].bounds.size.height;
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

@end
