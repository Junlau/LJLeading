//
//  LJProxy.h
//  LJDemo
//
//  Created by bobzhang 张博 on 2019/9/25.
//  Copyright © 2019 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJProxy : NSProxy{
    id _object;
}

+ (id)proxyForObject:(id)obj;


@end

NS_ASSUME_NONNULL_END
