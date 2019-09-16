//
//  TRCHTTPSessionManager.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 06/12/2016.
//  Copyright © 2016 泰然城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRCBaseSharedInstance.h"

@interface TRCHTTPSessionManager : TRCBaseSharedInstance


/**
 *  工程名
 */
@property (nonatomic, copy) NSString *productName;


@property (nonatomic, strong) NSString *userAgent;


@end
