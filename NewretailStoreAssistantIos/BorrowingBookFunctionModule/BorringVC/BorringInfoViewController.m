//
//  BorringInfoViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringInfoViewController.h"
#import "BorringBookScanViewController.h"

@interface BorringInfoViewController ()
{
    AssistantRequest *vipInfoRequest;
}
@property (nonatomic ,assign) NSInteger couldLendFlag;

@end

@implementation BorringInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    

    // Do any additional setup after loading the view from its nib.
}
-(void)requestTableViewDataSource{
    
    if (vipInfoRequest) {
        [vipInfoRequest cancel];
        vipInfoRequest = nil;
    }
    
    vipInfoRequest = [AssistantTask libraryManageLendInfoWithUserId:self.strScannedUserId successBlock:^(VipLendInfoModel * _Nonnull lendInfoModel) {
        self.couldLendFlag = lendInfoModel.couldLendFlag;
        if (self.couldLendFlag == 0) {
            [self.nextStep setTitle:@"不能再借了，知道了" forState:UIControlStateNormal];
        }else
            [self.nextStep setTitle:@"下一步" forState:UIControlStateNormal];

        [self.nikeName setText:lendInfoModel.userName];
        if ([lendInfoModel.userMemType isEqualToString:@"泰享会员"]) {
            [self.nikeImage setImage:[UIImage imageNamed:@"hyvip"]];
        }else
            [self.nikeImage setImage:[UIImage imageNamed:@""]];
        [self.remmantBorringCount setText:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:lendInfoModel.remainCount]]];
        [self.remainReturnCount setText:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:lendInfoModel.waitingReturnCount]]];
        [self.overdueCount setText:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:lendInfoModel.outTimeCount]]];

    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];

    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goNextStep:(id)sender {
    if (self.couldLendFlag == 0) {
        [self.nextStep setTitle:@"不能再借了，知道了" forState:UIControlStateNormal];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
    //点击下一步到扫码页面借阅
    [self resetBackButtonTitleWith:@"扫码借阅" and:[UIColor whiteColor]];
    BorringBookScanViewController *booringVC= [[BorringBookScanViewController alloc]init];
    booringVC.stepNum = 2;
        booringVC.strScannedUserId = self.strScannedUserId;
    [self.navigationController pushViewController:booringVC animated:YES];
    }
    
}
@end
