//
//  LJOperationViewController.m
//  LJDemo
//
//  Created by lj on 2019/5/24.
//  Copyright © 2019 LJ. All rights reserved.
//

#import "LJOperationViewController.h"

@interface LJModel : NSObject

@property (nonatomic, copy) NSString *title;
@end

@implementation LJModel

@end


@interface LJOperationViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timer1;
@end

@implementation LJOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加 __block之后 block锁定了a的地址
    __block int a = 10;
    void (^block)(void) = ^{
        NSLog(@"%d",a);
    };
    a = 20;
    block();
    
    /*
    //死锁，主线程里面同步线程调用主线程
    NSLog(@"1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    */
    
    LJModel *model1 = [LJModel new];
    model1.title = @"ces";
    NSMutableDictionary *mdic2 = [NSMutableDictionary dictionary];
    mdic2[@"b"] = @3;
    
    NSMutableArray *marray1 = [NSMutableArray array];
    [marray1 addObject:model1];
    [marray1 addObject:mdic2];
    
    NSMutableArray *marray2 = [marray1 copy];//copy过后是不可变类型
    
    NSLog(@"%p",marray1.firstObject);
    NSLog(@"%p",marray2.firstObject);
    
    //排序
    [self bubbleSortMethod:[@[@4,@5,@1,@6,@8,@3,@2,@7] mutableCopy]];
    
    return;
    // 添加主线程runloop监听者
    [self addMainObserver];
    
    // 添加子线程runloop监听者
    [self addOtherObserver];
    
    // 此处使用sleep是为了避免使用timer造成runloop的timer事件的干扰。
    sleep(3);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CGFloat randomAlpha = (arc4random() % 100)*0.01;
        [self.view setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:randomAlpha]];
    });
    
//    [self addOperationToQueue];
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


//runloop

// 添加子线程runloop监听者
- (void)addOtherObserver
{
    [NSThread detachNewThreadWithBlock:^{
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer)
                  {
                      NSLog(@"###cmm子线程###timer时间到");
                  }];
        
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            switch (activity) {
                case kCFRunLoopEntry:
                    NSLog(@"###cmm子线程###进入kCFRunLoopEntry");
                    break;
                    
                case kCFRunLoopBeforeTimers:
                    NSLog(@"###cmm子线程###即将处理Timer事件");
                    break;
                    
                case kCFRunLoopBeforeSources:
                    NSLog(@"###cmm子线程###即将处理Source事件");
                    break;
                    
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"###cmm子线程###即将休眠");
                    break;
                    
                case kCFRunLoopAfterWaiting:
                    NSLog(@"###cmm子线程###被唤醒");
                    break;
                    
                case kCFRunLoopExit:
                    NSLog(@"###cmm子线程###退出RunLoop");
                    break;
                    
                default:
                    break;
            }
        });
        
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
        
        [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        CFRunLoopRun();
    }];
}

// 添加主线程runloop监听者
- (void)addMainObserver
{
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
                
            case kCFRunLoopEntry:
                NSLog(@"###cmm###进入kCFRunLoopEntry");
                break;
                
            case kCFRunLoopBeforeTimers:
                NSLog(@"###cmm###即将处理Timer事件");
                break;
                
            case kCFRunLoopBeforeSources:
                NSLog(@"###cmm###即将处理Source事件");
                break;
                
            case kCFRunLoopBeforeWaiting:
                NSLog(@"###cmm###即将休眠");
                break;
                
            case kCFRunLoopAfterWaiting:
                NSLog(@"###cmm###被唤醒");
                break;
                
            case kCFRunLoopExit:
                NSLog(@"###cmm###退出RunLoop");
                break;
                
            default:
                break;
        }
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"###cmm###timer时间到");
    }];
}


//冒泡排序
- (void)bubbleSortMethod:(NSMutableArray *)sortArray {
    NSLog(@"---%@",sortArray);
    for (int i = 0; i < sortArray.count - 1; i++) {
        for (int j = 0; j < sortArray.count - i - 1; j++) {
            int a = [sortArray[j] intValue];
            int b = [sortArray[j + 1] intValue];
            if (a > b) {
                sortArray[j + 1] = [NSNumber numberWithInt:a];
                sortArray[j] = [NSNumber numberWithInt:b];
            }
            NSLog(@"%@",sortArray);
        }
    }
}

@end
