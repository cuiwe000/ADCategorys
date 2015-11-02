//
//  NSObject+SafeExp.h
//  CarPurifier
//
//  Created by msl on 15/9/2.
//  Copyright (c) 2015年 Haodi. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !defined(NSSE_USE_ASSERTIONS)
#define NSSEAssert(cond,desc,...) NSAssert(cond,desc,##__VA_ARGS__)
#else
#define NSSEAssert(cond,desc,...) do {} while (0)
#endif // NSSE_USE_ASSERTIONS
