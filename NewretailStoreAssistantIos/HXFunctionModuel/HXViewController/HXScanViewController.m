//
//  HXScanViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/20.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HXScanViewController.h"
#import "HXInputViewController.h"
#import "HXDetailsViewController.h"

@interface HXScanViewController ()
{
    AssistantRequest *checkCodeRequest;
    
}
@property (strong ,nonatomic) UIButton *scaninputBT;

@end

@implementation HXScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addSomeSubviews{
    
    [super addSomeSubviews];
    TRC_BLOCK_WEAK_SELF
    [self.qRScanView addSubview:self.scaninputBT];

    [self.scaninputBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.qRScanView);
        make.top.equalTo(weakSelf.qRScanView).with.offset(75+self.scanRect.origin.y+ self.scanRect.size.height);
        make.width.equalTo(@(weakSelf.view.bounds.size.width/2));

    }];
    self.toastLable.text =@"扫描出示的预约码";
    


    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
}

#pragma mark 扫码结果处理
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    __block  LBXScanResult *scanResult;
    
    if (array.count == 1) {
        
        scanResult = [array objectAtIndex:0];
        if (checkCodeRequest) {
            [checkCodeRequest cancel];
            checkCodeRequest = nil;
            
        }
        checkCodeRequest = [AssistantTask hxCheckItemInfoWithTypeId:self.typeId reservationCode:scanResult.strScanned successBlock:^(TRCResult *checkResult) {
            scanResult = [array objectAtIndex:0];
            NSLog(@"strScanned=%@",scanResult.strScanned);
            [self resetBackButtonTitleWith:@"预约详情"and:[UIColor clearColor]];
            HXDetailsViewController *hxDetailVC =[[HXDetailsViewController alloc]init];
            hxDetailVC.reservationCode = scanResult.strScanned;
            hxDetailVC.typeId = self.typeId;
            hxDetailVC.confirmBtDisplay = YES;
            
            [self.navigationController pushViewController:hxDetailVC animated:YES];
            
        } failureBlock:^(TRCResult *result) {
            [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];
            
        }];
        

    }else
        [self.view makeToast:@"未查询到该预约信息"];
    [self stopScan];
    
    [self reStartDevice];
}

-(UIButton *)scaninputBT{
    
    if (!_scaninputBT) {
        _scaninputBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scaninputBT setTitle:@"输入预约码核销" forState:UIControlStateNormal];
        [_scaninputBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_scaninputBT.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_scaninputBT addTarget:self action:@selector(pushNextHX) forControlEvents:UIControlEventTouchUpInside];
        _scaninputBT.layer.cornerRadius = 15;
        _scaninputBT.layer.masksToBounds = YES;
        _scaninputBT.backgroundColor =[[UIColor whiteColor] colorWithAlphaComponent:0.24];
        
    }
    return _scaninputBT;
}


-(void)pushNextHX{
    [self resetBackButtonTitleWith:@"输码核销" and:[UIColor clearColor]];
    HXInputViewController *hxinputVC =  [[HXInputViewController alloc]init];
    hxinputVC.typeId = self.typeId;
    [self.navigationController pushViewController:hxinputVC animated:YES];
    
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
