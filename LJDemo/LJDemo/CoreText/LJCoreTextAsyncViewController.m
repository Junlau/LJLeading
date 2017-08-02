//
//  LJCoreTextAsyncViewController.m
//  LJDemo
//
//  Created by lj on 2017/3/30.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJCoreTextAsyncViewController.h"
#import "LJTextView.h"

@interface LJCoreTextAsyncViewController ()

@end

@implementation LJCoreTextAsyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        LJTextView *textView = [[LJTextView alloc] initWithFrame:CGRectMake(0, 0, width, 64)];
        textView.backgroundColor = [UIColor clearColor];
        textView.tag = 100;
        textView.displaysAsynchronously = YES;
        [cell.contentView addSubview:textView];
    }
    LJTextView *textView = [cell.contentView viewWithTag:100];
    textView.textString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息刻度信息",(long)indexPath.row]];
    NSDictionary *dic = @{@"textClick":@"click",NSBackgroundColorAttributeName:[UIColor redColor]};
    [textView.textString addAttributes:dic range:NSMakeRange(24, 4)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
