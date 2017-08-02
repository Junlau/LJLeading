//
//  SwipeLeftInteractiveTransition.h
//  LJDemo
//
//  Created by lj on 2017/4/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SwipeLeftInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;
@property (nonatomic, strong) UIViewController *dismissVC;
- (void)wirePanToViewController:(UIViewController *)viewController;

@end
