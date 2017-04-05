//
//  LJCoreTextViewController.m
//  LJDemo
//
//  Created by lj on 2017/3/16.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJCoreTextViewController.h"
#import "LJTextView.h"

@interface LJCoreTextViewController ()

@end

@implementation LJCoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"CoreText";
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    LJTextView *textView = [[LJTextView alloc] initWithFrame:CGRectMake(0, 64, width, height - 64)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.textString = [[NSMutableAttributedString alloc]initWithString:@"刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息"];
    
    NSDictionary *dic = @{@"textClick":@"click",NSBackgroundColorAttributeName:[UIColor redColor]};
    [textView.textString addAttributes:dic range:NSMakeRange(24, 4)];
    
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
