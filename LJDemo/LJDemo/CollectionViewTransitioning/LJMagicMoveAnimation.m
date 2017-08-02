//
//  LJMagicMoveAnimation.m
//  LJDemo
//
//  Created by lj on 2017/4/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJMagicMoveAnimation.h"
#import "LJCollectionTranViewController.h"
#import "LJTranSecondViewController.h"
#import "LJCollectionViewCell.h"

@implementation LJMagicMoveAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    LJCollectionTranViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    LJTranSecondViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //首先拿到cell上的图片
    LJCollectionViewCell *cell = (LJCollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:[fromVC.collectionView indexPathsForSelectedItems].firstObject];
    fromVC.indexPath = [fromVC.collectionView indexPathsForSelectedItems].firstObject;
    
    UIView *snapShotView = [cell.mainImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = fromVC.finalCellRect = [containerView convertRect:cell.mainImageView.frame fromView:cell.mainImageView.superview];
    cell.mainImageView.hidden = YES;
    
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.mainImage.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.mainImage.frame fromView:toVC.mainImage.superview];
    } completion:^(BOOL finished) {
        toVC.mainImage.hidden = NO;
        [snapShotView removeFromSuperview];
        cell.mainImageView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
    
}
@end
