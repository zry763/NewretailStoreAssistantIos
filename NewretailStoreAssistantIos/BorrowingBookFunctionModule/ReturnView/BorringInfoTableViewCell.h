//
//  BorringInfoTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"


typedef void(^BookReturn)(void);
NS_ASSUME_NONNULL_BEGIN

@interface BorringInfoTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *borringTime;
@property (weak, nonatomic) IBOutlet UILabel *returnTime;
@property (weak, nonatomic) IBOutlet UILabel *borringCount;
- (IBAction)bookReturn:(id)sender;
@property(copy , nonatomic) BookReturn bookreturn;

@end

NS_ASSUME_NONNULL_END
