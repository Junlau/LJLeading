//
//  LJScrollViewController.m
//  LJDemo
//
//  Created by lj on 2017/5/4.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJScrollViewController.h"
#import "LJSecondScrollViewController.h"

#define maxOffsetY 150

@interface LJScrollViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate> {
    CGFloat width;
    CGFloat height;
    CGFloat currentPanY;
    
    BOOL mainScrollEnabled;
    BOOL subScrollEnabled;
    
    NSMutableArray *tableArray;
    
    CGPoint lastPoint;
}

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIScrollView *subScrollView;

@end

@implementation LJScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, width, height - 64)];
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 150)];
    view.backgroundColor = [UIColor redColor];
    [_mainScrollView addSubview:view];
    
    [_mainScrollView addSubview:self.subScrollView];
    self.mainScrollView.contentSize = CGSizeMake(width, 150 + self.subScrollView.frame.size.height);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    pan.delegate = self;
    [self.mainScrollView addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIScrollView *)subScrollView {
    if (_subScrollView == nil) {
        _subScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, width, height - 64)];
        _subScrollView.contentSize = CGSizeMake(width * 3, _subScrollView.frame.size.height);
        _subScrollView.pagingEnabled = YES;
        tableArray = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i * width, 0, width, _subScrollView.frame.size.height)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.scrollEnabled = NO;
            [_subScrollView addSubview:tableView];
            [tableArray addObject:tableView];
        }
    }
    return _subScrollView;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 26;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    cell.textLabel.text = @"1234567890";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LJSecondScrollViewController *second = [[LJSecondScrollViewController alloc]init];
    [self.navigationController pushViewController:second animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        if (scrollView.contentOffset.y >= maxOffsetY) {
            self.mainScrollView.scrollEnabled = NO;
            mainScrollEnabled = NO;
            for (UITableView *tableView in tableArray) {
                tableView.scrollEnabled = YES;
            }
            subScrollEnabled = YES;
        }
    } else {
        if (scrollView.contentOffset.y <= 0) {
            subScrollEnabled = NO;
            for (UITableView *tableView in tableArray) {
                tableView.scrollEnabled = NO;
            }
            self.mainScrollView.scrollEnabled = YES;
            mainScrollEnabled = YES;
            self.mainScrollView.contentOffset = CGPointMake(self.mainScrollView.contentOffset.x, self.mainScrollView.contentOffset.y  + scrollView.contentOffset.y);
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateChanged) {
        currentPanY = 0;
        mainScrollEnabled = NO;
        subScrollEnabled = NO;
    } else {
        //locationInView:获取到的是手指点击屏幕实时的坐标点；
        //translationInView：获取到的是手指移动后，在相对坐标中的偏移量
        CGFloat currentY = [recognizer translationInView:self.mainScrollView].y;
        //触及临界点
        if (mainScrollEnabled || subScrollEnabled) {
            if (currentPanY == 0) {
                currentPanY = currentY;
            }
            
            CGFloat offsetY = currentPanY - currentY;    //计算在临界点后的 offsetY
            
            if (mainScrollEnabled) {
                CGFloat supposeY = maxOffsetY + offsetY;
                if (supposeY >= 0) {
                    self.mainScrollView.contentOffset = CGPointMake(0, supposeY);
                }else {
                    self.mainScrollView.contentOffset = CGPointZero;
                }
            } else {
                for (UITableView *tableView in tableArray) {
                    if (offsetY <= 0) {
                        tableView.contentOffset = CGPointMake(0, 0);
                    } else {
                        tableView.contentOffset = CGPointMake(0, offsetY);
                    }
                }
            }
        }
    }
}

@end
