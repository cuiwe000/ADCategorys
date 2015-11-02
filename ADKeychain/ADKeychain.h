//
//  ADKeychain.h
//  CarPurifier
//
//  Created by msl on 15/8/20.
//  Copyright (c) 2015年 Haodi. All rights reserved.
//  用于 存储 用户 密码 个人信息

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface ADKeychain : NSObject

+(void)saveKey:(NSString *)service data:(id)data;

+(id)loadKey:(NSString *)service;

+(void)deleteKey:(NSString *)service;



@end
