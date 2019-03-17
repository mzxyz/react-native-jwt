
#import "RNJWT.h"
#import "JWT.h"

@implementation RNJWT

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(verify:(NSString *)token
                  key:(NSString *)key
                  signature:(NSString *)signature
                  algorithm:(NSString *)algorithm
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    @try
    {
        BOOL verified = [JWT verify:token withKey:key signature:signature algorithm:algorithm];
        resolve(@(verified));
    }
    @catch (NSException *ex)
    {
        [RNJWT reject:reject exception:ex];
    }
}

+ (void)reject:(RCTPromiseRejectBlock)reject exception:(NSException *)exception
{
    NSString *name = exception.name;
    NSString *reason = exception.reason;
    NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain
                                                code:0
                                            userInfo:@{@"message": reason}];
    
    if (reject) {
        reject(name, reason, error);
    }
}

@end
