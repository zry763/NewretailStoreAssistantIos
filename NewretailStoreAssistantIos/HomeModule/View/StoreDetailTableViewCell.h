//
//  StoreDetailTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/17.
//  Copyright © 2019 zry. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *backColorBT;
@property (weak, nonatomic) IBOutlet UILabel *storeIncome;
@property (weak, nonatomic) IBOutlet UILabel *shopkeepersNumber;
@property (weak, nonatomic) IBOutlet UILabel *increasedMember;

@end

NS_ASSUME_NONNULL_END
