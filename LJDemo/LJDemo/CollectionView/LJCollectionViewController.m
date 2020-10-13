//
//  LJCollectionViewController.m
//  LJDemo
//
//  Created by lj on 2017/4/20.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJCollectionViewController.h"
#import "DateCollectionViewCell.h"
#import "ContentCollectionViewCell.h"
#import "LJCustomCollectionViewLayout.h"

#define sections 50
#define rows 8

@interface LJCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource> {
    NSMutableArray *dataArray;
}

@end

@implementation LJCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    dataArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    for (int i = 0; i < sections; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0 ; j < rows; j++) {
            if (i == 0) {
                if (j == 0) {
                    [rowArray addObject:@"Date"];
                } else /*if (j != rows -1)*/ {
                    [rowArray addObject:[NSString stringWithFormat:@"%d号",j]];
                }
            } else {
                if (j == 0) {
                    [rowArray addObject:[NSString stringWithFormat:@"%d",i]];
                } else {
                    [rowArray addObject:[NSString stringWithFormat:@"表%d%d",i,j]];
                }
            }
        }
        [dataArray addObject:rowArray];
    }
    
    LJCustomCollectionViewLayout *layout = [[LJCustomCollectionViewLayout alloc]init];
    layout.dataArray = dataArray;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, width, height - 64) collectionViewLayout:layout];
    self.collectionView.directionalLockEnabled = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DateCollectionViewCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ContentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ContentCollectionViewCell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *rowsArray = dataArray[section];
    return rowsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DateCollectionViewCell *dateCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCollectionViewCell" forIndexPath:indexPath];
            
            dateCell.backgroundColor = [UIColor whiteColor];
            dateCell.dateLabel.font = [UIFont systemFontOfSize:13];
            dateCell.dateLabel.textColor = [UIColor blackColor];
            dateCell.dateLabel.text = dataArray[indexPath.section][indexPath.item];
            
            return dateCell;
        } else {
            ContentCollectionViewCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCollectionViewCell" forIndexPath:indexPath];
            contentCell.contentLabel.font = [UIFont systemFontOfSize:13];
            contentCell.contentLabel.textColor = [UIColor blackColor];
            contentCell.contentLabel.text = dataArray[indexPath.section][indexPath.item];
            
            if (indexPath.section % 2 != 0) {
                contentCell.backgroundColor = [UIColor colorWithWhite:242/255.0 alpha:1.0];
                
            } else {
                contentCell.backgroundColor = [UIColor whiteColor];
            }
            return contentCell;
        }
    } else {
        if (indexPath.row == 0) {
            DateCollectionViewCell *dateCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCollectionViewCell" forIndexPath:indexPath];
            dateCell.dateLabel.font = [UIFont systemFontOfSize:13];
            dateCell.dateLabel.textColor = [UIColor blackColor];
            dateCell.dateLabel.text = dataArray[indexPath.section][indexPath.item];
            if (indexPath.section % 2 != 0) {
                dateCell.backgroundColor = [UIColor colorWithWhite:242/255.0 alpha:1.0];
            } else {
                dateCell.backgroundColor = [UIColor whiteColor];
            }
            
            return dateCell;
        } else {
            ContentCollectionViewCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCollectionViewCell" forIndexPath:indexPath];
            contentCell.contentLabel.font = [UIFont systemFontOfSize:13];
            contentCell.contentLabel.textColor = [UIColor blackColor];
            contentCell.contentLabel.text = dataArray[indexPath.section][indexPath.item];
            if (indexPath.section % 2 != 0) {
                contentCell.backgroundColor = [UIColor colorWithWhite:242/255.0 alpha:1.0];
            } else {
                contentCell.backgroundColor = [UIColor whiteColor];
            }
            
            return contentCell;
        }
    }
}

@end
