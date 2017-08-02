//
//  LJModalViewController.h
//  LJDemo
//
//  Created by lj on 2017/4/26.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

-(void) modalViewControllerDidClickedDismissButton:(LJModalViewController *)viewController;

@end

@interface LJModalViewController : UIViewController
@property (nonatomic, assign)id<ModalViewControllerDelegate>delegate;
@end
