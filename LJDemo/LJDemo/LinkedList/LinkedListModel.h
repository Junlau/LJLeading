//
//  LinkedListModel.h
//  LJDemo
//
//  Created by lj on 2019/7/31.
//  Copyright © 2019 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@interface ListNode : NSObject
@property (nonatomic, assign) NSInteger data; //暂时用数字表示，方便学习
@property (nonatomic, strong) ListNode *next; //下一个
@property (nonatomic, strong) ListNode *prior; //上一个，双向链表时使用
@end

@interface LinkedListModel : NSObject
//四个方法
//增

//删

//改

//查

//查找是否循环

//翻转单链表
@end

NS_ASSUME_NONNULL_END
