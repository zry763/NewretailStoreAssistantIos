//
//  TRCBaseSharedInstance.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 9/30/16.
//  Copyright © 2016 陆佳峰. All rights reserved.
//

#import "TRCBaseSharedInstance.h"

static NSMutableDictionary *_sharedInstanceInfo = nil;

@implementation TRCBaseSharedInstance

+ (instancetype)sharedInstance {
    
    if (!_sharedInstanceInfo) {

        _sharedInstanceInfo = [NSMutableDictionary dictionary];
    }

    
    NSString *key = [NSString stringWithUTF8String:object_getClassName(self)];
    id _sharedInstance = _sharedInstanceInfo[key];
    
    if (!_sharedInstance) {
        
        _sharedInstance = [[self class] new];
        [_sharedInstanceInfo setObject:_sharedInstance forKey:key];
    }
    
    return _sharedInstance;
}


+ (instancetype)defaultManager {
    
    return [self sharedInstance];
}

@end
