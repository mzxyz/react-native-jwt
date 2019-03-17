//
//  JWTHSBase.m
//  RNJWT
//
//  Created by HZ on 1/08/18.
//  Copyright © 2018 HZ. All rights reserved.
//

#import "JWTHSBase.h"
#import <CommonCrypto/CommonHMAC.h>

NSString * const JWTAlgorithmHS256 = @"HS256";
NSString * const JWTAlgorithmHS384 = @"HS384";
NSString * const JWTAlgorithmHS512 = @"HS512";

@implementation JWTHSBase

+ (uint32_t)kCCHmacAlgorithm:(NSString *)algorithm {
    if([algorithm isEqualToString:JWTAlgorithmHS256]) {
        return kCCHmacAlgSHA256;
    } else if ([algorithm isEqualToString:JWTAlgorithmHS384]) {
        return kCCHmacAlgSHA384;
    } else if ([algorithm isEqualToString:JWTAlgorithmHS512]) {
        return kCCHmacAlgSHA512;
    } else {
        [JWTHSBase throwAlgorithmTypeException:algorithm];
    }
   
    return 0;
}

+ (int)digestLength:(NSString *)algorithm {
    if([algorithm isEqualToString:JWTAlgorithmHS256]) {
        return CC_SHA256_DIGEST_LENGTH;
    } else if ([algorithm isEqualToString:JWTAlgorithmHS384]) {
        return CC_SHA384_DIGEST_LENGTH;
    } else if  ([algorithm isEqualToString:JWTAlgorithmHS512]) {
        return CC_SHA512_DIGEST_LENGTH;
    } else {
        [JWTHSBase throwAlgorithmTypeException:algorithm];
    }
    
    return 0;
}

+ (void)throwAlgorithmTypeException:(NSString *)type {
    @throw [NSException exceptionWithName:@"Algorithm type error"
                                   reason:[NSString stringWithFormat:@"Algorithm type: %@ is not supported", type]
                                 userInfo:nil];
}

+ (NSString *)base64EncodeWithData:(NSData *)data {
    NSString * base64str = [data base64EncodedStringWithOptions:0];
    
    return [[[base64str stringByReplacingOccurrencesOfString:@"+" withString:@"-"]
             stringByReplacingOccurrencesOfString:@"/" withString:@"_"]
            stringByReplacingOccurrencesOfString:@"=" withString:@""];
}

+ (NSString *)sign:(NSString *)msg withKey:(NSString *)key algorithm:(NSString *)algorithm {
    size_t digestLen = [JWTHSBase digestLength:algorithm];
    size_t signaturelen = digestLen * sizeof(unsigned char);
    unsigned char* cHMAC = malloc(signaturelen);
    
    const char *cMsg = [msg cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
    
    CCHmacAlgorithm ccAlg = [JWTHSBase kCCHmacAlgorithm:algorithm];
    CCHmac(ccAlg, cKey, strlen(cKey), cMsg, strlen(cMsg), cHMAC);
    NSData *result = [[NSData alloc] initWithBytes:cHMAC length:signaturelen];
    free(cHMAC);
    
    return [JWTHSBase base64EncodeWithData:result];
}

+ (BOOL)verify:(NSString *)msg withKey:(NSString *)key signature:(NSString *)signature algorithm:(NSString *)algorithm {
    NSString *newSignature = [JWTHSBase sign:msg withKey:key algorithm:algorithm];
    return [newSignature isEqualToString:signature];
}

@end
