//
//  JWT.h
//  RNJWT
//
//  Created by HZ on 1/08/18.
//  Copyright © 2018 HZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWTAlgorithmProtocol.h"

@interface JWT : NSObject
/**
 *  Verify the signature with key and token
 *
 *  @param token       JsonWebToken string
 *  @param key         Key for HMAC algorithms
 *  @param algorithm   HMAC algorithms (currently)
 *
 *  @return BOOL
 */
+ (BOOL)verify:(NSString *)token withKey:(NSString *)key signature:(NSString *)signature algorithm:(NSString *)algorithm;

@end
