//
//  TRCBaseSharedInstance.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 9/30/16.
//  Copyright © 2016 陆佳峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCBaseSharedInstance : NSObject

/**
 *  单例模式
 *
 *  单例对象
 */
+ (instancetype)sharedInstance;


/**
 *  单例模式
 *
 *  单例对象
 */
+ (instancetype)defaultManager;


@end
