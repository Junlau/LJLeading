//
//  LJTimeEventViewController.m
//  LJDemo
//
//  Created by lj on 2020/5/31.
//  Copyright © 2020 LJ. All rights reserved.
//

#import "LJTimeEventViewController.h"

#define kStartTime 9 //表示从早上9点开始
#define kAllTHour 12 //表示显示多少个小时
#define kCellHeight 44 //cell的高度

#define kStartY 10
#define kStartX 65

@interface LJTimeEventChildView : UIView
@property (nonatomic, strong) NSMutableArray *drawArray; //用来标记占用几个cell
@property (nonatomic, copy) NSString *timeString;

@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation LJTimeEventChildView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.drawArray = [NSMutableArray array];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:self.bounds];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    self.timeLabel.frame = self.bounds;
}

- (void)setTimeString:(NSString *)timeString {
    self.timeLabel.text = timeString;
}
@end

@interface LJTimeEventViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView; //用来显示时间线
@property (nonatomic, strong) NSMutableArray *timeArray; //用来表示占用时间
@property (nonatomic, strong) NSMutableArray *viewArray; //用来存储显示的子view
@property (nonatomic, strong) NSMutableDictionary *numberDic; //用来存储每个时间段view的个数
@end

@implementation LJTimeEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    self.viewArray = [NSMutableArray array];
    self.timeArray = [NSMutableArray array];
    self.numberDic = [NSMutableDictionary dictionary];
    
    [self.timeArray addObject:@"9:00-10:00"];
    [self.timeArray addObject:@"9:00-11:00"];
    [self.timeArray addObject:@"9:00-12:00"];
    [self.timeArray addObject:@"11:00-12:00"];
    [self.timeArray addObject:@"14:00-15:00"];
    
    for (NSString *timeString in self.timeArray) {
        LJTimeEventChildView *childView = [self creatChildViewForm:timeString];
        [self.tableView addSubview:childView];
    }
    [self calculateViewWidth];
}

#pragma mark - Private
- (LJTimeEventChildView *)creatChildViewForm:(NSString *)timeString {
    NSArray *stringArray = [timeString componentsSeparatedByString:@"-"];
    NSInteger startIndex = kStartTime;
    NSInteger endIndex = kStartTime;
    if (stringArray.count > 1) {
        startIndex = [stringArray.firstObject integerValue];
        endIndex = [stringArray.lastObject integerValue];
    }
    
    CGFloat startY = kStartY + (startIndex - kStartTime) * kCellHeight;
    CGFloat height = (endIndex - startIndex) *kCellHeight;
    
    LJTimeEventChildView *childView = [[LJTimeEventChildView alloc]initWithFrame:CGRectMake(kStartX, startY, [UIScreen mainScreen].bounds.size.width - kStartX, height)];
    childView.backgroundColor = [UIColor redColor];
    for (int i = (int)startIndex; i < (int)endIndex; i++) {
        [childView.drawArray addObject:[NSNumber numberWithInt:i]];
    }
    childView.timeString = timeString;
    [self.viewArray addObject:childView];
    [self setDrawNumberDisplayCount:childView];
    return childView;
}

//算法是：计算每一个时间段需要展示的view个数，然后再通过个数来计算宽度，比如计算出10:00-11:00端一共有5个事件，则宽度就是除以5，再判断宽度是否大于现在的宽度，因为会重复计算
- (void)setDrawNumberDisplayCount:(LJTimeEventChildView *)childView {
    for (NSNumber *drawNumber in childView.drawArray) {
        //收集时间段的view
        NSMutableArray *childArry = self.numberDic[drawNumber];
        if (childArry == nil) {
            childArry = [NSMutableArray array];
        }
        [childArry addObject:childView];
        self.numberDic[drawNumber] = childArry;
    }
}

- (void)calculateViewWidth {
    CGFloat childViewWidth = [UIScreen mainScreen].bounds.size.width - kStartX;
    //计算出每个view的宽度
    for (LJTimeEventChildView *childView in self.viewArray) {
        CGFloat width = childViewWidth;
        for (NSNumber *drawNumber in childView.drawArray) {
            //读取存取的时间段的个数
            NSMutableArray *childArry = self.numberDic[drawNumber];
            if (childArry != nil) {
                int count = (int)childArry.count;
                CGFloat minWidth = childViewWidth / count;
                if (width > minWidth) {
                    width = minWidth;
                }
            }
        }
        CGRect frame = childView.frame;
        frame.size.width = width;
        childView.frame = frame;
    }
    //一个时间段内应该以最小的宽度为准
    for (NSMutableArray *childArray in self.numberDic.allValues) {
        CGFloat width = childViewWidth; //这个时间端内最小的width
        for (LJTimeEventChildView *childView in childArray) {
            if (width > childView.frame.size.width) {
                width = childView.frame.size.width;
            }
        }
        
        for (LJTimeEventChildView *childView in childArray) {
            CGRect frame = childView.frame;
            frame.size.width = width;
            childView.frame = frame;
        }
    }
    
    //主要是为了顺序取出
    NSMutableArray *frameArray = [NSMutableArray array]; //存储布局好的view
    CGFloat x = kStartX;
    for (int i = 0; i < kAllTHour; i++) {
        NSNumber *number = [NSNumber numberWithInt:(i + kStartTime)];
        NSMutableArray *childArray = self.numberDic[number];
        
        for (LJTimeEventChildView *childView in childArray) {
            if ([frameArray containsObject:childView]) {
                //判断是否已布局
                continue;
            }
            CGRect frame = childView.frame;
            frame.origin.x = x;
            while ([self judgeRect:frame inArray:frameArray]) {
                frame.origin.x = frame.origin.x + frame.size.width;
            }
            childView.frame = frame;
            [frameArray addObject:childView];
        }
    }
    
}

//判断坐标是否被占用
- (BOOL)judgeRect:(CGRect)rect inArray:(NSMutableArray *)frameArray {
    BOOL isContain = NO;
    for (LJTimeEventChildView *childView in frameArray) {
        if (CGRectIntersectsRect(childView.frame, rect)) {
            isContain = YES;
            break;
        }
    }
    return isContain;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kAllTHour + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellId"];
    UILabel *timeLabel = [cell.contentView viewWithTag:100];
    if (timeLabel == nil) {
        timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 50, 20)];
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.tag = 100;
        [cell.contentView addSubview:timeLabel];
    }
    UIView *timeLine = [cell.contentView viewWithTag:101];
    if (timeLine == nil) {
        timeLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame), timeLabel.frame.size.height / 2, [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(timeLabel.frame), 1)];
        timeLine.backgroundColor = [UIColor blackColor];
        timeLine.tag = 101;
        [cell.contentView addSubview:timeLine];
    }
    
    timeLabel.text = [NSString stringWithFormat:@"%ld:00",kStartTime + indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

#pragma mark - Lazying
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellId"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
