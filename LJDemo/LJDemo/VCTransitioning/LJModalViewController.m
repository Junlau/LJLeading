//
//  LJModalViewController.m
//  LJDemo
//
//  Created by lj on 2017/4/26.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJModalViewController.h"

@interface LJModalViewController ()



@end

@implementation LJModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(80.0, 210.0, 160.0, 40.0)];
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewControllerDidClickedDismissButton:)]) {
//        [self.delegate modalViewControllerDidClickedDismissButton:self];
//    }
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
