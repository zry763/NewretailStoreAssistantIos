
//
//Created by ESJsonFormatForMac on 19/10/18.
//

#import <Foundation/Foundation.h>

@class ReturnRecords,ReturnRecordList;
@interface VipReturnInfoModel : NSObject

@property (nonatomic, strong) NSArray *records;

@end
@interface ReturnRecords : NSObject

@property (nonatomic, assign) NSInteger recordID;

@property (nonatomic, assign) NSInteger storeId;

@property (nonatomic, assign) NSInteger delFlag;

@property (nonatomic, copy) NSString *shouldReturnTime;

@property (nonatomic, copy) NSString *lendingTime;

@property (nonatomic, copy) NSString *libraryManageNo;

@property (nonatomic, assign) NSInteger userLevelId;

@property (nonatomic, assign) NSInteger renewCount;

@property (nonatomic, copy) NSString *userLevelName;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *lendingOperator;

@property (nonatomic, assign) NSInteger lendingCount;

@property (nonatomic, copy) NSString *userMobile;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, assign) NSInteger isOverdue;

@property (nonatomic, assign) NSInteger status;

@end

@interface ReturnBookRecordInfo : NSObject

@property (nonatomic, assign) NSInteger lendingCount;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *goodsSn;

@property (nonatomic, copy) NSString *libraryManageNo;

@property (nonatomic, assign) NSInteger productId;

@property (nonatomic, copy) NSString *productName;

@end

