//
//  SLJPopView.m
//  LJDemo
//
//  Created by 19054909 on 2021/7/13.
//  Copyright © 2021 LJ. All rights reserved.
//

#import "SLJPopView.h"
#import "SLJTableViewCell.h"
@interface SLJContentView ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *closeButton;
@property (copy, nonatomic) void(^closeButtonClick)();
@end


@implementation SLJContentView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.closeButton];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)closeButtonPressed {
    if (self.closeButtonClick) {
        self.closeButtonClick();
    }
}

- (void)layoutSubviews {
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 50);
    self.closeButton.frame = CGRectMake(self.frame.size.width - 50, 0, 50, 50);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width, self.frame.size.height - CGRectGetMaxY(self.titleLabel.frame));
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SLJTableViewCellId"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

#pragma mark - Lazying

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"关联商品";
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor blackColor]; //#222222
    }
    return _titleLabel;
}

- (UIButton *)closeButton {
    if (_closeButton == nil) {
        _closeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 50, 0, 50, 50)];
        [_closeButton setTitle:@"X" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width, self.frame.size.height - CGRectGetMaxY(self.titleLabel.frame)) style:UITableViewStylePlain];
        UINib *nib = [UINib nibWithNibName:@"SLJTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"SLJTableViewCellId"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

@end

@interface SLJPopView ()
@property  (strong, nonatomic) SLJContentView *contentView;
@property  (strong, nonatomic) UIView *bgView;
@end

@implementation SLJPopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        [self addSubview:self.contentView];
    }
    return self;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return _bgView;
}

- (SLJContentView *)contentView {
    if (_contentView == nil) {
        _contentView = [[SLJContentView alloc]initWithFrame:CGRectMake(0,  self.frame.size.width - 50, 50, 50)];
        __weak __typeof(self) weakSelf = self;
        _contentView.closeButtonClick = ^{
            [weakSelf dissmissView];
        };
    }
    return _contentView;
}



- (void)popToView:(UIView *)sView{
    [sView addSubview:self];
    self.frame = sView.frame;
    self.bgView.frame = self.frame;
    self.contentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height/2);
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
    }];
}

- (void)dissmissView {
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height/2);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
