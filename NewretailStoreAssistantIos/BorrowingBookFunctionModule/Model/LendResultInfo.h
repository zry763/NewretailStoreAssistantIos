//
//Created by ESJsonFormatForMac on 19/10/21.
//

#import <Foundation/Foundation.h>

@class SaveList;
@interface LendResultInfo : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger storeId;

@property (nonatomic, copy) NSString *shouldReturnTime;

@property (nonatomic, copy) NSString *lendingTime;

@property (nonatomic, copy) NSString *libraryManageNo;

@property (nonatomic, assign) NSInteger userLevelId;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *lendingOperator;

@property (nonatomic, assign) NSInteger lendingCount;

@property (nonatomic, copy) NSString *userMobile;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, assign) NSInteger isOverdue;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *updateTime;

@end
@interface SaveList : NSObject

@property (nonatomic, copy) NSString *libraryManageNo;

@property (nonatomic, assign) NSInteger productId;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, assign) NSInteger lendingCount;

@property (nonatomic, copy) NSString *goodsSn;

@property (nonatomic, copy) NSString *createTime;

@end

