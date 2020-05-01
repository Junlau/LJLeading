//
//  TipsViewController.m
//  LJDemo
//
//  Created by lj on 2020/5/1.
//  Copyright © 2020 LJ. All rights reserved.
//

#import "TipsViewController.h"

@interface TipsViewController ()<UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint; //默认128

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) UILabel *placeholderLabel;
@end

@implementation TipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textView.delegate = self;
    self.textView.text = @"";
    [self.textView addSubview:self.placeholderLabel];
    
    self.textField.delegate = self;
    self.textField.placeholder = @"请输入文字";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChanged:) name:UITextViewTextDidChangeNotification object:self.textView];
    [self.textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}


- (void)dealloc {
    [self.textView removeObserver:self forKeyPath:@"text"];
    
}

#pragma mark - Lazying
- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 8, 40, 25)];
        _placeholderLabel.text = @"请输入文字";
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
        [_placeholderLabel sizeToFit];
    }
    return _placeholderLabel;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    //添加
    if (textView.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    } else {
        self.placeholderLabel.hidden = NO;
    }
    
    //控制字数
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (textView.text.length > self.maxNumber) {
            textView.text = [textView.text substringToIndex:self.maxNumber];
            //弹出提示框
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"最多输入%ld字",(long)self.maxNumber] preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self dismissViewControllerAnimated:alert completion:nil];
                });
            }];
        }
    } else{
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
    }
    
    
    //控制TextView高度
    [self resizeTextView:textView];
    
    
    //用正则匹配英文和数字
    //可以英文可以中文可以数字，英文自动变大写
//    NSString *pattern = @"^[a-zA-Z0-9\u4E00-\u9FA5]*$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:textView.text];
//    if (!isMatch) {
//
//    } else {
//
//    }
}

- (void)resizeTextView:(UITextView *)resizeTextView {
    CGSize maxSize = CGSizeMake(resizeTextView.frame.size.width, CGFLOAT_MAX);
    CGSize newSize = [resizeTextView sizeThatFits:maxSize];
    CGFloat height = ceilf(newSize.height); //便于计算的高度的小数取整
    if (height < 100) {
        height = 100;
    }
    self.textViewHeightConstraint.constant = height;
    
    //大段文本输入后的滚动
    resizeTextView.frame = CGRectMake(resizeTextView.frame.origin.x, resizeTextView.frame.origin.y, resizeTextView.frame.size.width, height);
    [resizeTextView scrollRangeToVisible:NSMakeRange(resizeTextView.text.length, 1)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.textView && [keyPath isEqualToString:@"text"]) {
        NSLog(@"监听UITextView的Text");
    }
}

#pragma mark - UITextFieldDelegate
//不适合，会导致字数达到后无法删除
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (textField.text.length > self.maxNumber) {
//        return NO;
//    }
//    return YES;
//}

- (void)textFieldDidChange:(UITextField *)changeTextField {
    NSString *pattern = @"^[a-zA-Z0-9@-_*]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self.textField.text];
    if (!isMatch) {
        
    } else {
        
    }
    
    if (self.textField.text.length > self.maxNumber) {
        self.textField.text = [self.textField.text substringToIndex:self.maxNumber];
    }
}

#pragma mark - UIScrollView Keyboard
//- (void) registerForKeyboardNotifications {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)keyboardWillShow:(NSNotification *)notification {
//    NSDictionary *info = [notification userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
//    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
//}
//
//- (void)keyboardWillHide:(NSNotification *)notification {
//    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//}
@end
