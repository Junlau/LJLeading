//
//  LJCollectionTranViewController.m
//  LJDemo
//
//  Created by lj on 2017/4/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJCollectionTranViewController.h"
#import "LJCollectionViewCell.h"
#import "LJTranSecondViewController.h"
#import "LJMagicMoveAnimation.h"
#import "LJMagicMovePopAnimation.h"

@interface LJCollectionTranViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UINavigationControllerDelegate>
@property (nonatomic, strong) LJMagicMoveAnimation *magicMoveAnimation;
@property (nonatomic, strong) LJMagicMovePopAnimation *magicPopAnimation;
@end

@implementation LJCollectionTranViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake((width - 10)/2, 190);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, width, height - 64) collectionViewLayout:flowLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LJCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LJCollectionViewCell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.delegate = self;
    _magicMoveAnimation = [[LJMagicMoveAnimation alloc]init];
    _magicPopAnimation = [[LJMagicMovePopAnimation alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    NSLog(@"11111");
}

#pragma mark <UICollectionViewDataSource>
//section的数目
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section Item的数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LJTranSecondViewController *second = [[LJTranSecondViewController alloc]init];
    [self.navigationController pushViewController:second animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if ([fromVC isEqual:self] && (operation == UINavigationControllerOperationPush)) {
        return _magicMoveAnimation;
    } else if ([toVC isEqual:self] && (operation == UINavigationControllerOperationPop)) {
        return _magicPopAnimation;
    } {
        return nil;
    }
}

@end
