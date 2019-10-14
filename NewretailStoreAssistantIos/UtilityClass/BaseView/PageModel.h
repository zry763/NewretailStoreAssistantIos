//
//  PageModel.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/12.
//  Copyright © 2019 zry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageModel : NSObject

/**
 *  当前页面编号
 */
@property (assign, nonatomic) NSInteger currPage;


/**
 *  页面总数
 */
@property (assign, nonatomic) NSInteger totalPage;


/**
 *  一页显示的条数
 */
@property (assign, nonatomic) NSInteger pageSize;


/**
 *  数据初始化
 */
- (void)initData;
@end

NS_ASSUME_NONNULL_END
