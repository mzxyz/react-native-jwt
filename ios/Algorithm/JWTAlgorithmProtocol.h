//
//  JWTAlgorithmProtocol.h
//  RNJWT
//
//  Created by HZ on 3/08/18.
//  Copyright © 2018 HZ. All rights reserved.
//

#ifndef JWTAlgorithmProtocol_h
#define JWTAlgorithmProtocol_h


#endif /* JWTAlgorithmProtocol_h */

@protocol JWTAlgorithmProtocol <NSObject>

@required
+ (NSString *)sign:(NSString *)msg withKey:(NSString *)key algorithm:(NSString *)algorithm;
+ (BOOL)verify:(NSString *)msg withKey:(NSString *)key signature:(NSString *)signature algorithm:(NSString *)algorithm;

@end
