//
//  AppDelegate.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/9.
//  Copyright © 2019 zry. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import <AFNetworkReachabilityManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    
    // 获取类库的单例变量 键盘遮挡处理全局可用
    keyboardManager.enable = YES; // 控制整个功能是否启用
    //键盘弹出时，点击背景，键盘收回
    keyboardManager.shouldResignOnTouchOutside = YES;
    //隐藏键盘上面的toolBar,默认是开启的
    keyboardManager.enableAutoToolbar = NO;
    self.window.backgroundColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTintColor:UIColor.blackColor];
    

    UIStoryboard *rootBoard;
    UIViewController *rootVC;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    if (![userDefault boolForKey:@"first"] ) {
//        [userDefault setBool:YES forKey:@"first"];
        rootBoard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:[NSBundle mainBundle]];

    }else{
        rootBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    }

    rootVC = [rootBoard instantiateInitialViewController];
    self.window.rootViewController = rootVC;



    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkworking) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginError) name:@"STORELOGINERROR" object:nil];

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    // Override point for customization after application launch.
    return YES;
}
-(void)loginError{
    
    
        [[UserInfoModel sharedInstance] logout];
   
        UIStoryboard *loginBoard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:[NSBundle mainBundle]];
        UIViewController *destVC = [loginBoard instantiateInitialViewController];
        destVC.modalPresentationStyle =  UIModalPresentationFullScreen;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:destVC animated:YES completion:nil];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first"];
        
    
    
    
}
#pragma mark 网络检测
-(void)checkworking

{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];

    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
          switch (status) {
                            case AFNetworkReachabilityStatusNotReachable:
                
                                [self alercontroller:0];
                
                                break;
                
                            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                                [self alercontroller:1];
                                break;
                
                
                            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                                [self alercontroller:2];
                                break;
                
                
                            default:
                
                                break;
                
                    }}];

    
    
}
// 设置弹窗



-(void)alercontroller:(int)stu
{
    NSString *netToast ;
    
    switch (stu) {
        case 0:
            netToast =@"当前无网络访问";
            break;
        case 1:
            netToast =@"当前网络为2/3/4G网络";

            break;
        case 2:
            netToast =@"当前网络为wifi网络";

            break;
        default:
            break;
    }
    [[UIApplication sharedApplication].keyWindow makeToast:netToast duration:1 position:CSToastPositionCenter];

}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
