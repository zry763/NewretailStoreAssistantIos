//
//  BookScanViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BookScanViewController.h"
#import "BorringProcessView.h"
#import "BorringInfoViewController.h"
#import "AssociateMemberViewController.h"

@interface BookScanViewController ()
{
    AssistantRequest *getuserIdRequest;
}
@property (strong ,nonatomic) BorringProcessView *processView;

@end

@implementation BookScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Do any additional setup after loading the view.
}


-(void)addSomeSubviews{
    
    [super addSomeSubviews];

    [self.view addSubview:self.processView];
    TRC_BLOCK_WEAK_SELF

    [self.processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.qRScanView).with.offset(15);
        make.centerX.equalTo(weakSelf.qRScanView);
        if ([BookScanViewController isPhoneX]) {
            make.top.equalTo(weakSelf.view).with.offset(88);
            
        }else
            make.top.equalTo(weakSelf.view).with.offset(64);
        
    }];

    self.toastLable.text= @"请扫描出示的二维码";
    [self.processView setupViewWithModel:self.stepModel];
    
}

-(BorringProcessView *)processView{
    if (!_processView) {
        _processView = [BorringProcessView viewFromNib];
    }
    return _processView;
}
#pragma mark 扫码结果处理
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    LBXScanResult *scanResult;
    if (array.count == 1) {
         scanResult = [array objectAtIndex:0];
        NSLog(@"strScanned=%@",scanResult.strScanned);
        
        UIViewController *destVC;
        AssociateMemberViewController *associateVC;
        BorringInfoViewController *borringVC;
           if (borringOrReturnFlag) {//借书
               borringVC = [[BorringInfoViewController alloc]init];
               borringVC.stepNum = 2;
               destVC = borringVC;
               [self resetBackButtonTitleWith:@"会员信息" and: [UIColor clearColor]];

                       
           }else//还书
           {
               associateVC = [[AssociateMemberViewController alloc]init];
               associateVC.stepNum = 1;
               destVC = associateVC;
               [self resetBackButtonTitleWith:@"图书归还" and: [UIColor clearColor]];
           }

           if (getuserIdRequest) {
               [getuserIdRequest cancel];
               getuserIdRequest = nil;
           }
           //获取会员id
           getuserIdRequest = [AssistantTask vipInfoWithNumber:scanResult.strScanned successBlock:^( NSString *vipInfoID) {
               if (borringOrReturnFlag) {
                   borringVC.strScannedUserId = vipInfoID;
               }else
                   associateVC.strScannedUserId = vipInfoID;
               [self.navigationController pushViewController:destVC animated:YES];

           } failureBlock:^(TRCResult *result) {
               [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];

           }];
        
    }else
        [self.view makeToast:@"为查询到该会员信息"];
    [self stopScan];
    
    [self reStartDevice];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
