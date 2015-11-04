//
//  NSString+Helpers.m
//  AdeMusic
//
//  Created by msl on 15/10/29.
//  Copyright © 2015年 adi. All rights reserved.
//

#import "NSString+ADHelpers.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ADHelpers)

- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)MD5{
    return [[self md5] uppercaseString];
}

- (NSString *)stringByUrlEncoding{
    static NSString *const kAFCharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    static NSString * const kAFCharactersToLeaveUnescaped = @"[].";
    
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, (__bridge CFStringRef)kAFCharactersToLeaveUnescaped, (__bridge CFStringRef)kAFCharactersToBeEscaped, kCFStringEncodingUTF8);
}

- (NSMutableDictionary *)dictionaryFromQueryString{
    if (self == nil) {
        return  nil;
    }
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSRange range = [pair rangeOfString:@"="];
        NSString *key,*value;
        if(range.location  != NSNotFound){
            key = [pair substringToIndex:range.location];
            value = [[pair substringFromIndex:range.location+1]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else {
            key = pair;
            value = @"";
        }
        key = [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [result setObject:value forKey:key];
    }
    return result;
}

#pragma mark -
#pragma mark 字符串 size
- (CGSize)sizeForWidth:(CGFloat)width andFont:(UIFont*)font{
    CGSize size;
    CGSize constraintSize = CGSizeMake(width, CGFLOAT_MAX);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        size = [self boundingRectWithSize:constraintSize
                                  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                               attributes:@{NSFontAttributeName:font}
                                  context:nil].size;
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        
        size = [self sizeWithFont:font
                constrainedToSize:constraintSize
                    lineBreakMode:NSLineBreakByWordWrapping];
        
#pragma clang diagnostic pop
    }
#else
    size = [self sizeWithFont:font
            constrainedToSize:constraintSize
                lineBreakMode:UILineBreakModeWordWrap];
#endif
    return size;
}

- (CGFloat)heightForWidth:(CGFloat)width andFont:(UIFont*)font
{
    CGSize size = [self sizeForWidth:width andFont:font];
    return ceil(size.height);
}

- (CGFloat)widthToFitFont:(UIFont*)font
{
    CGSize size;
    CGSize constraintSize = CGSizeMake(CGFLOAT_MAX, font.lineHeight);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        size = [self boundingRectWithSize:constraintSize
                                  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                               attributes:@{NSFontAttributeName:font}
                                  context:nil].size;
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        
        size = [self sizeWithFont:font
                constrainedToSize:constraintSize
                    lineBreakMode:NSLineBreakByTruncatingTail];
        
#pragma clang diagnostic pop
    }
#else
    size = [self sizeWithFont:font
            constrainedToSize:constraintSize
                lineBreakMode:UILineBreakByTruncatingTail];
#endif
    
    return ceil(size.width);
}

#pragma mark -
#pragma mark
- (bool)isEmpty {
    return self.length == 0;
}

- (NSString *)trim {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSNumber *)numericValue {
    return [NSNumber numberWithUnsignedLongLong:[self longLongValue]];
}

@end
