//
//  LJOperationViewController.m
//  LJDemo
//
//  Created by lj on 2019/5/24.
//  Copyright © 2019 LJ. All rights reserved.
//

#import "LJOperationViewController.h"

@interface LJOperationViewController ()

@end

@implementation LJOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addOperationToQueue];
}

//详细介绍 https://juejin.im/post/5a9e57af6fb9a028df222555

- (void)addOperationToQueue {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 1; // 串行
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task1) object:nil];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task2) object:nil];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    
}

- (void)task1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    }
}

- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
    }
}

@end
