//
//  UITableView+FooterManager.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/16.
//  Copyright © 2019 zry. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (FooterManager)
/**是否开启<数据不满一页的话就自动隐藏下面的mj_footer>功能*/
@property(nonatomic, assign) BOOL autoHideMjFooter;
@end

NS_ASSUME_NONNULL_END
