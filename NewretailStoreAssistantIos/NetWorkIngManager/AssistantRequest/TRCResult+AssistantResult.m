//
//  TRCResult+AssistantResult.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/16.
//  Copyright © 2019 zry. All rights reserved.
//

#import "TRCResult+AssistantResult.h"
static const NSString *KEY_RESPONSECODE = @"RESPONSECODE";
static const NSString *KEY_RESPONSECONTENT = @"RESPONSECONTENT";
static const NSString *KEY_OUTPUT = @"OUTPUT";

@implementation TRCResult (AssistantResult)

+ (id)resultFromResponseObject:(NSDictionary *)responseObject {
    
    TRCResult *result = [TRCResult new];
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        if ([responseObject.allKeys containsObject:@"code"]&&[responseObject.allKeys containsObject:@"msg"]&&[responseObject.allKeys containsObject:@"data"]) {
            
            result.responseCode = [[responseObject objectForKey:@"code"] integerValue];
            result.responseContent = [responseObject objectForKey:@"msg"];
            result.output = [responseObject objectForKey:@"data"];
            return result;
            
        }

    }
    
    
    
    
    return result;
    
    
}

- (BOOL)isNumberStr:(NSString *)strValue
{
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}


- (BOOL)success {
    
    return self.responseCode == TRCFinanceResponseCodeSuccess || self.responseCode == 200;
}
@end
