//
//  SLJViewController.m
//  LJDemo
//
//  Created by 19054909 on 2021/7/13.
//  Copyright © 2021 LJ. All rights reserved.
//

#import "SLJViewController.h"
#import "SLJPopView.h"

@interface SLJViewController ()

@end

@implementation SLJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *popButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 80, 50)];
    [popButton setTitle:@"POP" forState:UIControlStateNormal];
    [popButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popButton];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)buttonPressed {
    SLJPopView *slj = [[SLJPopView alloc]init];
    [slj popToView:self.view];
}

@end
