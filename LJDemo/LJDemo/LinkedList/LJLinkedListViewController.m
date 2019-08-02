//
//  LJLinkedListViewController.m
//  LJDemo
//
//  Created by lj on 2019/7/31.
//  Copyright © 2019 LJ. All rights reserved.
//

#import "LJLinkedListViewController.h"

@interface LJLinkedListViewController ()

@end

@implementation LJLinkedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeStringToCharArray:@"qwertyuioop"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)changeStringToCharArray:(NSString *)text {
    if (text.length > 0) {
        char charArray[text.length];
        for (int i = 0; i < text.length; i++) {
            charArray[i] = [text characterAtIndex:i];
        }
        for (int i = 0; i < sizeof(charArray); i++) {
            NSLog(@"%c",charArray[i]);
        }
    }
}

@end
