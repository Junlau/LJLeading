//
//  LJTextLayout.m
//  LJDemo
//
//  Created by lj on 2017/3/29.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJTextLayout.h"
#import <libkern/OSAtomic.h>
#import "LJTextView.h"

//创建线程队列，参考YYText
/// Global display queue, used for content rendering.
static dispatch_queue_t LJTextAsyncLayerGetDisplayQueue() {
#define MAX_QUEUE_COUNT 16
    static int queueCount;
    static dispatch_queue_t queues[MAX_QUEUE_COUNT];
    static dispatch_once_t onceToken;
    static int32_t counter = 0;
    dispatch_once(&onceToken, ^{
        queueCount = (int)[NSProcessInfo processInfo].activeProcessorCount;
        queueCount = queueCount < 1 ? 1 : queueCount > MAX_QUEUE_COUNT ? MAX_QUEUE_COUNT : queueCount;
        if ([UIDevice currentDevice].systemVersion.floatValue > 8.0) {
            for (int i = 0; i < queueCount; i++) {
                //DISPATCH_QUEUE_SERIAL或者NULL，表示创建串行队列，优先级为目标队列优先级。dispatch_queue_attr_make_with_qos_class函数可以创建带有优先级的dispatch_queue_attr_t对象。通过这个对象可以自定义queue的优先级。
                dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
                queues[i] = dispatch_queue_create("com.lj.coretext.render", attr);
            }
        } else {
            for (int i = 0; i < queueCount; i++) {
                //调用dispatch_set_target_queue会retain新目标队列queue，release原有目标队列。设置目标队列之后，block将会在目标队列中执行。
                queues[i] = dispatch_queue_create("com.lj.coretext.render", DISPATCH_QUEUE_SERIAL);
                dispatch_set_target_queue(queues[i], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
            }
        }
    });
    uint32_t cur = (uint32_t)OSAtomicIncrement32(&counter);
    return queues[(cur) % queueCount];
#undef MAX_QUEUE_COUNT
}



//参考YYText，线程安全的计数
/// a thread safe incrementing counter.
@interface _TextSentinel : NSObject
/// Returns the current value of the counter.
@property (atomic, readonly) int32_t value;
/// Increase the value atomically. @return The new value.
- (int32_t)increase;
@end

@implementation _TextSentinel {
    int32_t _value;
}
- (int32_t)value {
    return _value;
}
- (int32_t)increase {
    return OSAtomicIncrement32(&_value);
}
@end

@implementation LJTextLayout {
    _TextSentinel *_sentinel;
}

- (id)init {
    self = [super init];
    _displaysAsynchronously = NO;
    _sentinel = [_TextSentinel new];
    return self;
}

- (void)dealloc {
    [_sentinel increase];
}

- (void)setNeedsDisplay {
    //[self _cancelAsyncDisplay];
    [_sentinel increase];
    [super setNeedsDisplay];
}

- (void)display {
    super.contents = super.contents;
    [self displayAsync:_displaysAsynchronously];
}

- (void)displayAsync:(BOOL)async {
    if (async) {
        _TextSentinel *sentinel = _sentinel;
        //如果刷新太快，取消以前的刷新
        int32_t value = sentinel.value;
        BOOL (^isCanceled)() = ^BOOL(){
            return value != sentinel.value;
        };
        BOOL opaque = self.opaque;
        CGColorRef backgroundColor = (opaque && self.backgroundColor) ? CGColorRetain(self.backgroundColor) : NULL;
        dispatch_async(LJTextAsyncLayerGetDisplayQueue(), ^{
            if (isCanceled()) {
                CGColorRelease(backgroundColor);
                return;
            }
            
            //需要将内容变成CGImage然后赋值给contents,用于layer展示
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, self.contentsScale);
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            //如果有背景色需填充背景色
            if (opaque) {
                CGSize size = self.bounds.size;
                size.width *= self.contentsScale;
                size.height *= self.contentsScale;
                CGContextSaveGState(context);//记录上下文的当前状态
                {
                    if (!backgroundColor || CGColorGetAlpha(backgroundColor) < 1) {
                        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                        CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
                        CGContextFillPath(context);
                    }
                    if (backgroundColor) {
                        CGContextSetFillColorWithColor(context, self.backgroundColor);
                        CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
                        CGContextFillPath(context);
                    }
                }
                CGContextRestoreGState(context);
                CGColorRelease(backgroundColor);
            }
            
            LJTextView *coreView = (LJTextView *)self.delegate;
            [coreView drawTextAndImage:context size:self.bounds.size];
            UIImage *imgae = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            if (isCanceled()) {
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!isCanceled()) {
                     self.contents = (__bridge id)(imgae.CGImage);
                }
            });
        });
    } else {
        [_sentinel increase];
        //需要将内容变成CGImage然后赋值给contents,用于layer展示
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, self.contentsScale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //如果有背景色需填充背景色
        if (self.opaque) {
            CGSize size = self.bounds.size;
            size.width *= self.contentsScale;
            size.height *= self.contentsScale;
            CGContextSaveGState(context);//记录上下文的当前状态
            {
                if (!self.backgroundColor || CGColorGetAlpha(self.backgroundColor) < 1) {
                    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
                    CGContextFillPath(context);
                }
                if (self.backgroundColor) {
                    CGContextSetFillColorWithColor(context, self.backgroundColor);
                    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
                    CGContextFillPath(context);
                }
            }
            CGContextRestoreGState(context);
        }
        
        LJTextView *coreView = (LJTextView *)self.delegate;
        [coreView drawTextAndImage:context size:self.bounds.size];
        UIImage *imgae = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.contents = (__bridge id)(imgae.CGImage);
    }
}


@end
