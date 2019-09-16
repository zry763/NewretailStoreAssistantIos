//
//  TRCRequestCacheManager.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 29/03/2017.
//  Copyright © 2017 泰然城. All rights reserved.
//

#import "TRCRequestCacheManager.h"


@interface TRCRequestCacheManager ()

/**
 *  缓存的文件路径
 */
- (NSString *)cacheFilePathWithCacheFileName:(NSString *)cacheFileName;


/**
 *  缓存的文件夹路径
 */
- (NSString *)cacheBasePath;

@end


@implementation TRCRequestCacheManager


#pragma mark - Public Methods
#pragma mark 根据缓存文件名获取缓存数据对象
- (id)cachedResponseObjectWithCacheFileName:(NSString *)cacheFileName {
    
    NSString *path = [self cacheFilePathWithCacheFileName:cacheFileName];
    
    if (!path) {
        
        return nil;
    }
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir;
    
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        
        if (!isDir) {
            
            @try {
                
                NSError *error = nil;
                
                NSData *jsonData = [NSData dataWithContentsOfFile:path];
                
                id JSONObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&error];
                if(error) {
                    NSLog(@"json解析失败：%@",error);
                    return nil;
                }
                
                return JSONObject;
                
            } @catch (NSException *exception) {
                
                NSLog(@"load cache failed, reason = %@", exception.reason);
            }
        }
    }
    
    return nil;
}


#pragma mark 根据缓存文件名缓存数据对象
- (void)saveResponseObjectToCacheFile:(id)responseObject cacheFileName:(NSString *)cacheFileName {
    
    @try {
        
        // New data will always overwrite old data.
        if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]]) {
            
            NSError *error = nil;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
            
            if ([jsonData length] > 0 && error == nil){
                
                [jsonData writeToFile:[self cacheFilePathWithCacheFileName:cacheFileName] options:NSDataWritingAtomic error:&error];

                if (error) {
                    
                    NSLog(@"%@", error);
                    [self removeCachedFileWithCacheFileName:cacheFileName];
                }
                
            }
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"Save cache failed, reason = %@", exception.reason);
    }
}


#pragma mark 根据缓存文件名移除缓存数据
- (void)removeCachedFileWithCacheFileName:(NSString *)cacheFileName {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir;
    
    NSString *cacheFilePath = [self cacheFilePathWithCacheFileName:cacheFileName];
    
    if ([fileManager fileExistsAtPath:cacheFilePath isDirectory:&isDir]) {
        
        if (!isDir) {
            
            NSError *error = nil;
            [fileManager removeItemAtPath:cacheFilePath error:&error];
        }
    }
}



#pragma mark 清除所有缓存数据
- (void)cleanAllCachedFiles {
 
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString * cacheBasePath = [self cacheBasePath];
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:cacheBasePath error:nil];
    
    for (NSInteger i = 0; i < [fileList count]; i++) {
        
        [fileManager removeItemAtURL:[fileList objectAtIndex:i] error:nil];
    }
}


#pragma mark -  Private Methods
#pragma mark 缓存的文件路径
- (NSString *)cacheFilePathWithCacheFileName:(NSString *)cacheFileName {
    
    NSString *path = [self cacheBasePath];
    
    if (path) {
    
        path = [path stringByAppendingPathComponent:cacheFileName];
        return path;
    }
    
    return nil;
}


#pragma mark 缓存的文件夹路径
- (NSString *)cacheBasePath {
    
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"TRCRequestCache"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path isDirectory:nil]) {
        
        NSError *error = nil;
        
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            
            NSLog(@"%@", error);
            return nil;
        }
    }
    
    return path;
}

@end
