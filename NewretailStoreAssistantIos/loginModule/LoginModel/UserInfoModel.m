//
//  UserInfoModel.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/9.
//  Copyright © 2019 zry. All rights reserved.
//

#import "UserInfoModel.h"
/**
 *  SandBox中Document的路径
 */
#define THDocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/*
 *  用户基本信息文件缓存路径
 */
#define TRCAccountInfoModelCacheFilePath [THDocumentPath stringByAppendingPathComponent:@"StoreAccountInfoModelCacheFilePath"]
static UserInfoModel *_sharedInfo = nil;

@implementation UserInfoModel

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedInfo = [[UserInfoModel alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:TRCAccountCenteTokenInvalidNotification object:nil];
        
    });
    
    return _sharedInfo;
    
}
// 解档
- (id)initWithCoder:(NSCoder *)aDecoder {
      if (self = [super init]) {
          self.email = [aDecoder decodeObjectForKey:@"email"];
          self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
          self.storeId = [aDecoder decodeObjectForKey:@"storeId"];
          self.storeName = [aDecoder decodeObjectForKey:@"storeName"];
          
          self.storeNumber = [aDecoder decodeObjectForKey:@"storeNumber"];
          self.token = [aDecoder decodeObjectForKey:@"token"];
          self.userId = [aDecoder decodeObjectForKey:@"userId"];
          self.username = [aDecoder decodeObjectForKey:@"username"];
      

      }
      return self;
}
// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.storeId forKey:@"storeId"];
    [aCoder encodeObject:self.storeName forKey:@"storeName"];
    
    [aCoder encodeObject:self.storeNumber forKey:@"storeNumber"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.username forKey:@"username"];

}

#pragma mark  解档用户信息数据,程序启动时需要调用
-(UserInfoModel *)accountInfoUnarchiver {
    
    NSString *path = [self userCookieCachePath];
    
    UserInfoModel *userModel =  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    self.email = userModel.email;
    self.mobile = userModel.mobile;
    self.storeId = userModel.storeId;
    self.storeName = userModel.storeName;
    self.storeNumber  = userModel.storeNumber;
    self.token = userModel.token;
    self.userId = userModel.userId;
    self.username = userModel.username;
    
    return userModel;
    
}

#pragma mark 归档
- (void)archiveUserInfo:(UserInfoModel *)userinfo
{
    
    NSString *path = [[UserInfoModel sharedInstance] userCookieCachePath];
    
    BOOL suc= [NSKeyedArchiver archiveRootObject:userinfo toFile:path];
    if (suc) {

         NSLog(@"user 归档成功！");

     }else{

         NSLog(@"user 归档失败！");

     }
}


#pragma mark 清空归档
- (void)clearArchiver {
    
    
    NSString *path = [self userCookieCachePath];
    
    //删除归档文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:path]) {
        [defaultManager removeItemAtPath:path error:nil];
    }
    
}
#pragma mark 退出登陆
+ (void)logout {
    
    [[UserInfoModel sharedInstance] logout];
    
}
-(NSString*)userCookieCachePath {
    
    return TRCAccountInfoModelCacheFilePath;
    
}


- (void)logout{
    
    [self clearArchiver];
    self.email = nil;
    self.mobile = nil;
    self.storeId = nil;
    self.storeName = nil;
    self.storeNumber  = nil;
    self.token = nil;
    self.userId = nil;
    self.username = nil;
    
}
@end
