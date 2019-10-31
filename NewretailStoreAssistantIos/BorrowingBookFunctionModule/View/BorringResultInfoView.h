//
//  BorringResultInfoView.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//借书最后一步信息

#import "TRCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BorringResultInfoView : TRCBaseView
@property (weak, nonatomic) IBOutlet UILabel *lendCount;
@property (weak, nonatomic) IBOutlet UILabel *shouldReturnTime;

@end

NS_ASSUME_NONNULL_END
