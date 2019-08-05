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
#import "LJLinkedListViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Demo";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObjectsFromArray:@[@"CoreText",@"CoreTextAsync",@"CollectionView",@"VCTransitioning",@"CollectionViewTransitioning",@"HashTable",@"ScrollViewInScrollView",@"Loading",@"BezierPath",@"Operation",@"DataStructure"]];
    
   /*
    LLDB 汇编调试 使用符号断点进入汇编：
    架构定义调用约定了哪个指令哪位参数到函数和它返回的值被保存。
    在Objective-C中，RDI 寄存器用来引用调用的对象，RSI 是selector,RDX 是首个参数等等。
    在Swift中，RDI 是第一个参数，RSI第 二个参数，然后等等，只要Swift方法不使用动态分发(dynamic dispatch)。
    -RAX 寄存器为函数返回值使用，不管你是用在用OC还是Swift。
    当使用$打印寄存器的时候，确认当前环境是OC。
    */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self.dataArray removeLastObject];
//    });
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.navigationController.delegate = nil;
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
        //viewcontroller 在被 present 或者 push 出来之前，调用了 controller 持有的 view 的方法，就会触发 viewDidLoad
        LJOperationViewController *Operation = [[LJOperationViewController alloc]init];
        [self.navigationController pushViewController:Operation animated:YES];
    }else if (indexPath.row == 10) {
        //viewcontroller 在被 present 或者 push 出来之前，调用了 controller 持有的 view 的方法，就会触发 viewDidLoad
        LJLinkedListViewController *linkedList = [[LJLinkedListViewController alloc]init];
        [self.navigationController pushViewController:linkedList animated:YES];
    }
}

@end
