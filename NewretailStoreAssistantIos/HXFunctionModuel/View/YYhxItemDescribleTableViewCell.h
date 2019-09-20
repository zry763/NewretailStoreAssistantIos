//
//  YYhxItemDescribleTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYhxItemDescribleTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemDescribleLable;
@property (weak, nonatomic) IBOutlet UILabel *itemCount;

@end

NS_ASSUME_NONNULL_END
