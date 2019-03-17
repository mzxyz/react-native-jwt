//
//  JWT.m
//  RNJWT
//
//  Created by HZ on 1/08/18.
//  Reference: https://github.com/ducreyna/objective-c-JWT-simple/
//
//  Copyright © 2018 HZ. All rights reserved.
//

#import "JWT.h"
#import "JWTHSBase.h"
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (Base64)
@end

@implementation NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string {
    NSString *formattedString = [[string stringByReplacingOccurrencesOfString:@"-" withString:@"+"]
              stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    
    NSUInteger size = [formattedString length] % 4;
    NSMutableString *base64String = [[NSMutableString alloc] initWithString:formattedString];
    for (int i = 0; i < size; i++) {
        [base64String appendString:@"="];
    }
    
    return [[NSData alloc] initWithBase64EncodedString:base64String options:0];
}

@end

@implementation JWT

// TODO: enable to support other algorithm: RS* ES*
+ (NSString *)sign:(NSString *)msg withKey:(NSString *)key algorithm:(NSString *)algorithm {    
    return [JWTHSBase sign:msg withKey:key algorithm:algorithm];
}

+ (BOOL)verify:(NSString *)token withKey:(NSString *)key signature:(NSString *)signature algorithm:(NSString *)algorithm {    
    return [JWTHSBase verify:token withKey:key signature:signature algorithm:algorithm];
}

@end
