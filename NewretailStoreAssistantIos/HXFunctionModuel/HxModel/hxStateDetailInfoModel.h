//
//Created by ESJsonFormatForMac on 19/10/12.
//

#import <Foundation/Foundation.h>

@class GoodslistModel;
@interface hxStateDetailInfoModel : NSObject

@property (nonatomic, assign) NSInteger storeId;

@property (nonatomic, assign) NSInteger confirmUserId;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger typeId;

@property (nonatomic, copy) NSString *activityTime;

@property (nonatomic, copy) NSString *reservationCode;

@property (nonatomic, copy) NSString *activityImg;

@property (nonatomic, strong) NSArray *goodsList;

@property (nonatomic, copy) NSString *activityName;

@property (nonatomic, assign) NSInteger orderId;

@property (nonatomic, copy) NSString *addTime;

@property (nonatomic, assign) NSInteger orderStatus;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *orderStatusStr;

@property (nonatomic, copy) NSString *confirmUserName;

@property (nonatomic, copy) NSString *confirmTime;

@end
@interface GoodslistModel : NSObject

@property (nonatomic, assign) NSInteger refundNumber;

@property (nonatomic, copy) NSString *isReal;

@property (nonatomic, assign) NSInteger promotionAmount;

@property (nonatomic, copy) NSString *discountRateStr;

@property (nonatomic, assign) CGFloat skuTotalPrice;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *pospalProductUid;

@property (nonatomic, copy) NSString *discountRate;

@property (nonatomic, copy) NSString *listPicUrl;

@property (nonatomic, copy) NSString *goodsSpecifitionIds;

@property (nonatomic, assign) NSInteger promotionPrice;

@property (nonatomic, copy) NSString *pospalDiscount;

@property (nonatomic, copy) NSString *goodsId;

@property (nonatomic, assign) NSInteger discountAmount;

@property (nonatomic, assign) NSInteger productId;

@property (nonatomic, assign) NSInteger stockPrice;

@property (nonatomic, assign) NSInteger goodsStatus;

@property (nonatomic, assign) NSInteger refundMoney;

@property (nonatomic, assign) NSInteger marketPrice;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, assign) NSInteger memberPrice;

@property (nonatomic, assign) CGFloat retailPrice;

@property (nonatomic, copy) NSString *pospalTotalAmount;

@property (nonatomic, copy) NSString *memberDiscountPrice;

@property (nonatomic, assign) CGFloat goodsAmount;

@property (nonatomic, copy) NSString *goodsSn;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *goodsSpecifitionNameValue;

@end

