//
//  HXTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HXTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hxItemImage;
@property (weak, nonatomic) IBOutlet UILabel *hxItemName;

@property (weak, nonatomic) IBOutlet UIImageView *hxItemStateImage;
@property (weak, nonatomic) IBOutlet UILabel *hxItemTime;
@property (weak, nonatomic) IBOutlet UILabel *hxItemdes;
@end

NS_ASSUME_NONNULL_END
