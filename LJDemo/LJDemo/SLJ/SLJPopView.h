//
//  SLJPopView.h
//  LJDemo
//
//  Created by 19054909 on 2021/7/13.
//  Copyright © 2021 LJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface SLJContentView : UIView

@end


@interface SLJPopView : UIView
- (void)popToView:(UIView *)sView;
- (void)dissmissView;
@end

NS_ASSUME_NONNULL_END
