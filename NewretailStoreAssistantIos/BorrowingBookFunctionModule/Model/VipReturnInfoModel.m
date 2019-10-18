//
//Created by ESJsonFormatForMac on 19/10/18.
//

#import "VipReturnInfoModel.h"
@implementation VipReturnInfoModel

+ (NSDictionary *)objectClassInArray{
    return @{@"records" : [ReturnRecords class]};
}

@end

@implementation ReturnRecords

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [ReturnBookRecordInfo class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"recordID": @"id"};
}
@end


@implementation ReturnBookRecordInfo

@end


