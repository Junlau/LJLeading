//
//  LJMainViewController.m
//  LJDemo
//
//  Created by lj on 2017/4/26.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJMainViewController.h"
#import "LJModalViewController.h"
#import "LJBouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "SwipeUpInteractiveTransition.h"
#import "SwipeLeftInteractiveTransition.h"

@interface LJMainViewController ()<ModalViewControllerDelegate, UIViewControllerTransitioningDelegate> {
    BOOL isClick;
}
@property (nonatomic, strong) LJBouncePresentAnimation *presentAnimation;
@property (nonatomic, strong) NormalDismissAnimation *dismissAnimation;
@property (nonatomic, strong) SwipeUpInteractiveTransition *swipeUpAnimation;
@property (nonatomic, strong) SwipeLeftInteractiveTransition *swipeLeftAnimation;

@property (nonatomic, strong) LJModalViewController *modal;
@end

@implementation LJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(80.0, 210.0, 160.0, 40.0)];
    [button setTitle:@"Present" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    _presentAnimation = [LJBouncePresentAnimation new];
    _dismissAnimation = [NormalDismissAnimation new];
    _swipeUpAnimation = [SwipeUpInteractiveTransition new];
    _swipeLeftAnimation = [SwipeLeftInteractiveTransition new];
    
    
    _modal = [[LJModalViewController alloc]init];
    _modal.delegate = self;
    _modal.transitioningDelegate = self;
    _swipeLeftAnimation.dismissVC = _modal;
    [self.swipeUpAnimation wirePanToViewController:_modal];
    [self.swipeLeftAnimation wirePanToViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentClick:(UIButton *)button {
//    LJModalViewController *modal = [[LJModalViewController alloc]init];
//    modal.delegate = self;
//    modal.transitioningDelegate = self;
//    [self.swipeUpAnimation wirePanToViewController:modal];
    isClick = YES;
    [self presentViewController:_modal animated:YES completion:^{
        
    }];
}

#pragma mark - ModalViewControllerDelegate
- (void)modalViewControllerDidClickedDismissButton:(LJModalViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _presentAnimation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return _dismissAnimation;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (_swipeUpAnimation.interacting) {
        return _swipeUpAnimation;
    } else {
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (_swipeLeftAnimation.interacting) {
        return _swipeLeftAnimation;
    } else {
        return nil;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
