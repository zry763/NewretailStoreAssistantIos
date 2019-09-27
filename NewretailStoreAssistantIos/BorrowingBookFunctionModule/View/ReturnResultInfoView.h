//
//  ReturnResultInfoView.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
////还书最后一步信息


#import "TRCBaseView.h"

typedef void(^ContinueReturnMyself)(void);
NS_ASSUME_NONNULL_BEGIN

@interface ReturnResultInfoView : TRCBaseView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
- (IBAction)contiuneReturnMyself:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *continueReturnBT;
@property(copy ,nonatomic ) ContinueReturnMyself  ContinueReturnBlock;

@end

NS_ASSUME_NONNULL_END
