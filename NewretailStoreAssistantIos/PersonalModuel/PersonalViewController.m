//
//  PersonalViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/25.
//  Copyright © 2019 zry. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()
{
    AssistantRequest *loginoutRequest;
    AssistantRequest *userinfoRequest;

}

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //从容器顶部开始布局UIRectEdgeNone
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {

        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    self.view.backgroundColor = [TRCColor colorFromHexCode:@"#f6f6f6"];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.hbd_barAlpha = 0.0;
    self.hbd_barStyle = UIBarStyleBlack;
    self.hbd_tintColor = UIColor.whiteColor;
    [self setupSubviews];
    

}
-(void)setupSubviews
{
    UserInfoModel *infoModel = [[UserInfoModel sharedInstance]  accountInfoUnarchiver];
    [self.storeName setText:infoModel.storeName];
    [self.loginUserName setText:infoModel.username];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [self.currentVersion setText: app_Version];
    
}
-(void)loginoutWithType:(NSInteger )status
{
    if (loginoutRequest) {
        [loginoutRequest cancel];
        loginoutRequest = nil;
    }
   
    loginoutRequest = [AssistantTask loginoutsuccessBlock:^(TRCResult * _Nonnull loginResult) {
        if (loginResult.responseCode == 0) {// 退出成功
            [[UserInfoModel sharedInstance] logout];
            if (status == 1) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"storeNumber"];
            }
            UIStoryboard *loginBoard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:[NSBundle mainBundle]];
             UIViewController *destVC = [loginBoard instantiateInitialViewController];
             destVC.modalPresentationStyle =  UIModalPresentationFullScreen;
            [self.navigationController presentViewController:destVC animated:YES completion:nil];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first"];

        }
        
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];
    }];
        
}
-(void)dealloc{

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginOut:(id)sender {
    [self loginoutWithType:0];// 退出登录
}

- (IBAction)loginOutCurrentStore:(id)sender {
    [self loginoutWithType:1];//退出门店

}
@end
