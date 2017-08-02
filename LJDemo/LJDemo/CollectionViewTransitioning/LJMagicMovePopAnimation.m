//
//  LJMagicMovePopAnimation.m
//  LJDemo
//
//  Created by lj on 2017/4/28.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJMagicMovePopAnimation.h"
#import "LJCollectionTranViewController.h"
#import "LJTranSecondViewController.h"
#import "LJCollectionViewCell.h"

@implementation LJMagicMovePopAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    LJTranSecondViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    LJCollectionTranViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    LJCollectionViewCell *cell = (LJCollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.indexPath];
    cell.mainImageView.hidden = YES;
    
    UIView *snapView = [fromVC.mainImage snapshotViewAfterScreenUpdates:NO];
    snapView.frame = [containerView convertRect:fromVC.mainImage.frame fromView:fromVC.mainImage.superview];
    
    fromVC.mainImage.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapView];
    [containerView sendSubviewToBack:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
        snapView.frame = toVC.finalCellRect;
    } completion:^(BOOL finished) {
        [snapView removeFromSuperview];
        cell.mainImageView.hidden = NO;
        fromVC.mainImage.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
    
    
}

@end
