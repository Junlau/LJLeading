//
//  LJBezierViewController.m
//  LJDemo
//
//  Created by lj on 2018/6/26.
//  Copyright © 2018年 LJ. All rights reserved.
//

#import "LJBezierViewController.h"
#import "LJPathView.h"

@interface LJBezierViewController () {
    UITextField *textField;
}

@end

@implementation LJBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"BezierPath";
    self.view.backgroundColor = [UIColor whiteColor];
    
    LJPathView *path = [[LJPathView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    path.backgroundColor = [UIColor grayColor];
    path.center = self.view.center;
    [self.view addSubview:path];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, 150, 44)];
    [textField becomeFirstResponder];
    textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:textField];
    
    NSString *tvName = @"1234567890";
    textField.text = tvName;
    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(180, 64, 44, 44)];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed {
    [self selectedRange];
    [self selectTextForInput:textField atRange:NSMakeRange(2, 0)];
}

//修改UITextField光标的位置
- (void)selectTextForInput:(UITextField *)input atRange:(NSRange)range {
    UITextPosition *start = [input positionFromPosition:[input beginningOfDocument] offset:range.location];
    UITextPosition *end = [input positionFromPosition:start offset:range.length];
    [input setSelectedTextRange:[input textRangeFromPosition:start toPosition:end]];
}

//获取UITextField光标的位置
- (NSRange)selectedRange
{
    UITextPosition* beginning = textField.beginningOfDocument;
    
    UITextRange* selectedRange = textField.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    NSInteger location = [textField offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
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
