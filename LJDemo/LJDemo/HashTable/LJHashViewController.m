//
//  LJHashViewController.m
//  LJDemo
//
//  Created by lj on 2017/5/3.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJHashViewController.h"

//hash数组最大值
#define max 15

@interface LJHashViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *normalLabel;

@property (strong, nonatomic) NSMutableArray *hashArray;
@property (strong, nonatomic) NSMutableArray *normalArray;
@end

@implementation LJHashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.desLabel.text = @"";
    [self creatHashArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)comfirmButtonPressed:(id)sender {
    [self.textField resignFirstResponder];
    [self removeValue:self.textField.text];
}


- (void)creatHashArray {
    //创建一个0-100的哈希数组
    _hashArray = [NSMutableArray array];
    for (int i = 0; i < max + 1; i++) {
        [_hashArray addObject:[NSMutableArray array]];
    }
    _normalArray = [NSMutableArray array];
    for (int i = 0; i < 1000; i++) {
        NSString *numberString = [NSString stringWithFormat:@"%d",i];
        NSInteger index = [self hashIndex:numberString];
        NSMutableArray *childArray = [_hashArray objectAtIndex:index];
        if (childArray == nil || childArray.count == 0) {
            childArray = [NSMutableArray array];
            [childArray addObject:numberString];
        } else {
            [childArray addObject:numberString];
        }
        _hashArray[index] = childArray;
        
        [_normalArray addObject:numberString];
    }
}

//除留余数法
- (NSInteger)hashIndex:(NSString *)numberString {
    NSInteger hash = [numberString hash];
    return hash%max;
}

//根据输入取出对应的值
- (void)removeValue:(NSString *)numberString {
    NSTimeInterval nowTime = [[NSDate date]timeIntervalSince1970];
    NSInteger index = [self hashIndex:numberString];
    NSMutableArray *childArray = [_hashArray objectAtIndex:index];
    if (childArray.count == 0) {
        self.desLabel.text = @"hash算法出错";
    }else if (childArray.count == 1) {
        self.desLabel.text = [NSString stringWithFormat:@"取出%@用时%f",childArray.firstObject,[[NSDate date]timeIntervalSince1970] - nowTime];
    }else if (childArray.count > 1) {
        int j = -1;
        for (int i = 0; i < childArray.count; i++) {
            if (numberString.intValue == [childArray[i] intValue]) {
                j = i;
                break;
            }
        }
        if (j < 0) {
            self.desLabel.text = @"未找到";
        } else {
            self.desLabel.text = [NSString stringWithFormat:@"取出%@用时%f",childArray[j],[[NSDate date]timeIntervalSince1970] - nowTime];
        }
    }
    
    nowTime = [[NSDate date]timeIntervalSince1970];
    
    int a = -1;
    for (int i = 0; i < _normalArray.count; i++) {
        if (numberString.intValue == [_normalArray[i] intValue]) {
            a = i;
            break;
        }
    }
    if (a < 0) {
        self.normalLabel.text = @"未找到";
    } else {
        self.normalLabel.text = [NSString stringWithFormat:@"取出%@用时%f",_normalArray[a],[[NSDate date]timeIntervalSince1970] - nowTime];
    }
}

@end
