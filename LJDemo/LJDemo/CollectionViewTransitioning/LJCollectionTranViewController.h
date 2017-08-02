//
//  LJCollectionTranViewController.h
//  LJDemo
//
//  Created by lj on 2017/4/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJCollectionTranViewController : UIViewController
@property (strong, nonatomic) UICollectionView *collectionView;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)CGRect finalCellRect;
@end
