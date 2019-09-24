//
//  ReturnBookHeaderView.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "TRCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReturnBookHeaderView : TRCBaseView

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UILabel *dataCount;
@property (weak, nonatomic) IBOutlet UILabel *describeLable;
@end

NS_ASSUME_NONNULL_END
