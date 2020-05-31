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
    self.view.backgroundColor = [UIColor whiteColor];
    [self changeStringToCharArray:@"qwertyuiopa"];
    
    NSLog(@"%@",NSStringFromClass([self class]));
    NSLog(@"%@",NSStringFromClass([super class]));
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
        //将字符串转为字符数组
        const char *charArray = [text UTF8String];
        char *cpy = calloc([text length], 1);
        strncpy(cpy, charArray, [text length]);
        
//        char charArray[text.length];
//        for (int i = 0; i < text.length; i++) {
//            charArray[i] = [text characterAtIndex:i];
//        }
        
        //将字符数组前后倒置
//        int count = (int)sizeof(cpy);
        int count = (int)strlen(cpy);
        for (int i = 0; i < count/2; i++) {
            char temp = cpy[i];
            cpy[i] = cpy[count - 1 - i];
            cpy[count - 1 - i] = temp;
        }
        
        
        
        NSString *marketPacket = [NSString stringWithCString:cpy encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", marketPacket);
        //未解决字符串中包括汉字的问题
    }
}

@end
