//
//  HXSearchViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HXSearchViewController : BaseTableViewController<UISearchBarDelegate>
@property(nonatomic ,copy) NSString *typeId;//项目类型id

@end

NS_ASSUME_NONNULL_END
