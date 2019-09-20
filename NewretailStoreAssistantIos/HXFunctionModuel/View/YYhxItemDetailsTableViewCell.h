//
//  YYhxItemDetailsTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYhxItemDetailsTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemDetailImage;
@property (weak, nonatomic) IBOutlet UILabel *itemDetailTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemDetailTime;

@end

NS_ASSUME_NONNULL_END
