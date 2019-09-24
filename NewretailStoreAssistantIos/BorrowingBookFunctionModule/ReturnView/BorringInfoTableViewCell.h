//
//  BorringInfoTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BorringInfoTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *borringTime;
@property (weak, nonatomic) IBOutlet UILabel *returnTime;
@property (weak, nonatomic) IBOutlet UILabel *borringCount;
- (IBAction)bookReturn:(id)sender;

@end

NS_ASSUME_NONNULL_END
