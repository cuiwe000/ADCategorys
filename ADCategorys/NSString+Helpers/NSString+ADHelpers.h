//
//  NSString+Helpers.h
//  AdeMusic
//
//  Created by msl on 15/10/29.
//  Copyright © 2015年 adi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ADHelpers)

/**
 *  对 string md5 加密 返回小写
 */
- (NSString *)md5;
// 返回大写
- (NSString *)MD5;

/**
 *  对 中文或者符号的 字符串url 转码
 */
- (NSString *)stringByUrlEncoding;

/**
 *  对 key1=value1&key2=value2 转成 字典
 *
 *  @return @{key1:value1,key2:value2}
 */
- (NSMutableDictionary *)dictionaryFromQueryString;

#pragma mark - 字符串 size
- (CGSize)sizeForWidth:(CGFloat)width andFont:(UIFont*)font;
- (CGFloat)heightForWidth:(CGFloat)width andFont:(UIFont*)font;
- (CGFloat)widthToFitFont:(UIFont*)font;

#pragma mark -
- (bool)isEmpty;
- (NSString *)trim;
- (NSNumber *)numericValue;

#pragma mark - 正则表达式 验证 validate

@end
