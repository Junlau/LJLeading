//
//  LJProxy.m
//  LJDemo
//
//  Created by bobzhang 张博 on 2019/9/25.
//  Copyright © 2019 LJ. All rights reserved.
//

#import "LJProxy.h"


@implementation LJProxy

+ (id)proxyForObject:(id)obj {
    LJProxy *instance = [LJProxy alloc];
    instance->_object = obj;
    
    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_object methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([_object respondsToSelector:invocation.selector]) {
        NSString *selectorName = NSStringFromSelector(invocation.selector);
        
        NSLog(@"Before calling \"%@\".", selectorName);
        [invocation invokeWithTarget:_object];
        NSLog(@"After calling \"%@\".", selectorName);
    }
}

@end
