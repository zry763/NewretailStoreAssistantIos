//
//  TRCRequestCacheManager.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 29/03/2017.
//  Copyright © 2017 泰然城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRCBaseSharedInstance.h"

@interface TRCRequestCacheManager : TRCBaseSharedInstance


/**
 *  根据缓存文件名获取缓存数据对象
 */
- (id)cachedResponseObjectWithCacheFileName:(NSString *)cacheFileName;


/**
 *  根据缓存文件名缓存数据对象
 */
- (void)saveResponseObjectToCacheFile:(id)responseObject cacheFileName:(NSString *)cacheFileName;


/**
 *  根据缓存文件名移除缓存数据
 */
- (void)removeCachedFileWithCacheFileName:(NSString *)cacheFileName;


/**
 *  清除所有缓存数据
 */
- (void)cleanAllCachedFiles;


@end
