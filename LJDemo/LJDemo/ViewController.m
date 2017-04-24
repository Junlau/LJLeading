//
//  ViewController.m
//  LJDemo
//
//  Created by lj on 2017/3/16.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "ViewController.h"
#import "LJCoreTextViewController.h"
#import "LJCoreTextAsyncViewController.h"
#import "LJCollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Demo";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"CoreText";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"CoreTextAsync";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"CollectionView";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        LJCoreTextViewController *coreText = [[LJCoreTextViewController alloc]init];
        [self.navigationController pushViewController:coreText animated:YES];
    }else if (indexPath.row == 1) {
        LJCoreTextAsyncViewController *async = [[LJCoreTextAsyncViewController alloc]init];
        [self.navigationController pushViewController:async animated:YES];
    }else if (indexPath.row == 2) {
        LJCollectionViewController *collection = [[LJCollectionViewController alloc]init];
        [self.navigationController pushViewController:collection animated:YES];
    }
}

@end
