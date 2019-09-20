//
//  BaseTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/17.
//  Copyright © 2019 zry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell
- (void)setUpWithModel:(id)model;
- (UIImage *)getBackGroundImageWithimgae:(UIImage*) image forsize:(CGSize )size;

@end

NS_ASSUME_NONNULL_END
