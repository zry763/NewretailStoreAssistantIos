//
//  HomePageTableViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewController.h"
#import "StoreDetailTableViewCell.h"
#import "FunctionTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomePageTableViewController : BaseTableViewController
@property(strong ,nonatomic) StoreDetailTableViewCell *storeDetailCell;
@property(strong ,nonatomic) FunctionTableViewCell *functionCell;

@end

NS_ASSUME_NONNULL_END
