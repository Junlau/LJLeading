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
#import "LJMainViewController.h"
#import "LJCollectionTranViewController.h"
#import "LJHashViewController.h"
#import "LJScrollViewController.h"
#import "LJLoadViewController.h"
#import "LJBezierViewController.h"
#import "LJOperationViewController.h"

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
    return 10;
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
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"VCTransitioning";
    }else if (indexPath.row == 4) {
        cell.textLabel.text = @"CollectionViewTransitioning";
    }else if (indexPath.row == 5) {
        cell.textLabel.text = @"HashTable";
    }else if (indexPath.row == 6) {
        cell.textLabel.text = @"ScrollViewInScrollView";
    }else if (indexPath.row == 7) {
        cell.textLabel.text = @"Loading";
    }else if (indexPath.row == 8) {
        cell.textLabel.text = @"BezierPath";
    }else if (indexPath.row == 9) {
        cell.textLabel.text = @"Operation";
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
    }else if (indexPath.row == 3) {
        LJMainViewController *collection = [[LJMainViewController alloc]init];
        [self.navigationController pushViewController:collection animated:YES];
    }else if (indexPath.row == 4) {
        LJCollectionTranViewController *collection = [[LJCollectionTranViewController alloc]init];
        [self.navigationController pushViewController:collection animated:YES];
    }else if (indexPath.row == 5) {
        LJHashViewController *hash = [[LJHashViewController alloc]init];
        [self.navigationController pushViewController:hash animated:YES];
    }else if (indexPath.row == 6) {
        LJScrollViewController *scroll = [[LJScrollViewController alloc]init];
        [self.navigationController pushViewController:scroll animated:YES];
    }else if (indexPath.row == 7) {
        LJLoadViewController *load = [[LJLoadViewController alloc]init];
        [self.navigationController pushViewController:load animated:YES];
    }else if (indexPath.row == 8) {
        LJBezierViewController *bezier = [[LJBezierViewController alloc]init];
        [self.navigationController pushViewController:bezier animated:YES];
    }else if (indexPath.row == 9) {
        LJOperationViewController *Operation = [[LJOperationViewController alloc]init];
        [self.navigationController pushViewController:Operation animated:YES];
    }
}

@end
