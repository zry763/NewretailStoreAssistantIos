//
//  BorringBookScanViewController.m
//  NewretailStoreAssistantIos
//
//  Created by Z-Mac on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringBookScanViewController.h"
#import "OrderInfoViewController.h"
#import "OrderInfoPresentationController.h"
#import "BookResultDetailViewController.h"
#import "BorringInputViewController.h"
NSMutableArray *orderArray;

@interface BorringBookScanViewController (){
    
    AssistantRequest *confirmRequest;
     AssistantRequest *vilidRequest;

}


@property (strong ,nonatomic) UIButton *scaninputBT;//输码借阅
@property(strong ,nonatomic) UIButton *confirmBt;//确认借阅
@property(strong ,nonatomic) UIButton *orderBt;//详单按钮
@property(strong ,nonatomic) UILabel *orderCountLable;//详单数量
@property (strong , nonatomic) libraryRecordModel *recordModel;

@end

@implementation BorringBookScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    orderArray = [[NSMutableArray alloc]init];
    self.recordModel.userId = self.strScannedUserId;
    self.recordModel.storeId = [[UserInfoModel sharedInstance] accountInfoUnarchiver].storeId;
    
    // Do any additional setup after loading the view.
}

-(libraryRecordModel*)recordModel{
    if (!_recordModel) {
        _recordModel = [[libraryRecordModel alloc]init];
    }
    
    return _recordModel;
    
}


-(void)addSomeSubviews{
    
    [super addSomeSubviews];
    [self.qRScanView addSubview:self.scaninputBT];
    TRC_BLOCK_WEAK_SELF

    [self.scaninputBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.qRScanView);
        make.top.equalTo(weakSelf.qRScanView).with.offset(75+self.scanRect.origin.y+ self.scanRect.size.height);
        make.width.equalTo(@(weakSelf.view.bounds.size.width/2));
        
    }];
    self.toastLable.text= @"扫描出示的书籍条码";
    
    [self.view addSubview:self.confirmBt];
    [self.confirmBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(70);
        make.bottom.equalTo(self.view).with.offset(-35);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(44));
        
    }];
    [self.view addSubview:self.orderBt];
    [self.orderBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(18);;
        make.bottom.equalTo(self.confirmBt.mas_top).with.offset(-25);
        make.width.equalTo(@(105));
        make.height.equalTo(@(36));

        
    }];
    [self.view addSubview:self.orderCountLable];
    [self.orderCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-15);
        make.centerY.equalTo(self.orderBt);
        make.width.equalTo(@(24));
        make.height.equalTo(@(24));
        
        
    }];

    

}


-(UIButton *)scaninputBT{
    
    if (!_scaninputBT) {
        _scaninputBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scaninputBT setTitle:@"输入图书条码" forState:UIControlStateNormal];
        [_scaninputBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_scaninputBT.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_scaninputBT addTarget:self action:@selector(pushInputNumber) forControlEvents:UIControlEventTouchUpInside];
        _scaninputBT.layer.cornerRadius = 15;
        _scaninputBT.layer.masksToBounds = YES;
        _scaninputBT.backgroundColor =[[UIColor whiteColor] colorWithAlphaComponent:0.24];
        
    }
    return _scaninputBT;
}

//输码借书
-(void)pushInputNumber{
    
    BorringInputViewController *booknumVC =[[BorringInputViewController alloc]init];
    booknumVC.strScannedUserId = self.strScannedUserId;
    booknumVC.transitioningDelegate = self;// 此对象要实现 UIViewControllerTransitioningDelegate 协议
    booknumVC.modalPresentationStyle=UIModalPresentationCustom;
    booknumVC.orderDelegete = ^{
         [self.orderCountLable setText:[NSString stringWithFormat:@"%lu",(unsigned long)orderArray.count]];
      };

    [self presentViewController:booknumVC animated:NO completion:nil];

    
}

//确认借阅
-(UIButton *)confirmBt{
    if (!_confirmBt) {
        _confirmBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBt.backgroundColor = [TRCColor colorFromHexCode:@"#D33A31"];
        [_confirmBt.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_confirmBt setTitle:@"确认借阅" forState:UIControlStateNormal];
        [_confirmBt addTarget:self action:@selector(confirmBorring) forControlEvents:UIControlEventTouchUpInside];
        _confirmBt.layer.cornerRadius = 22;
        _confirmBt.layer.masksToBounds = YES;
    }
    return _confirmBt;
}
-(void)confirmBorring{
    
    self.recordModel.list = orderArray;
    
    if (confirmRequest) {
        [confirmRequest cancel];
        confirmRequest = nil;
    }
    confirmRequest = [AssistantTask libraryManageSaveInfoWithRecord:self.recordModel successBlock:^(LendResultInfo * _Nonnull projectItemDetailModel) {
        if (projectItemDetailModel) {
            [self resetBackButtonTitleWith:@"图书借阅" and: [UIColor clearColor]];
            BookResultDetailViewController *bookResultVC =[[BookResultDetailViewController alloc]init];
            bookResultVC.stepNum = 3;
            bookResultVC.lendCount = [NSString stringWithFormat:@"%ld",(long)projectItemDetailModel.lendingCount];
            bookResultVC.renturnTime = projectItemDetailModel.shouldReturnTime;
            [bookResultVC.goonBorringBT setTitle:@"继续借书" forState:UIControlStateNormal];
            
            [self.navigationController pushViewController: bookResultVC animated:YES];
        }
        
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];

    }];

}
//订单
-(UIButton *)orderBt{
    if (!_orderBt) {
        _orderBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderBt.backgroundColor = TRCColorFromRGBA(0xff000000, 0.24);
        [_orderBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _orderBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _orderBt.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_orderBt.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_orderBt setTitle:@"详单" forState:UIControlStateNormal];
        [_orderBt addTarget:self action:@selector(orderInfo) forControlEvents:UIControlEventTouchUpInside];
        _orderBt.layer.cornerRadius = 18;
        _orderBt.layer.masksToBounds = YES;
    }
    return _orderBt;
}
//订单数量
-(UILabel *)orderCountLable{
    if (!_orderCountLable) {
        _orderCountLable = [[UILabel alloc]init];
        _orderCountLable.textAlignment = NSTextAlignmentCenter;
        _orderCountLable.backgroundColor = [TRCColor colorFromHexCode:@"#EC924A"];
        [_orderCountLable setTextColor:[UIColor whiteColor]];
        _orderCountLable.layer.cornerRadius = 12;
        _orderCountLable.layer.masksToBounds = YES;
        _orderCountLable.text = @"0";
        
    }
    return _orderCountLable;
}
//详单按钮
-(void)orderInfo{
    NSLog(@"详单");
    
    OrderInfoViewController *orderInfoVC = [[OrderInfoViewController alloc]init];
    orderInfoVC.transitioningDelegate = self;// 此对象要实现 UIViewControllerTransitioningDelegate 协议
    orderInfoVC.modalPresentationStyle=UIModalPresentationCustom;
    orderInfoVC.orderDelegete = ^{
       [self.orderCountLable setText:[NSString stringWithFormat:@"%lu",(unsigned long)orderArray.count]];
    };


    [self presentViewController:orderInfoVC animated:NO completion:nil];
    
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{

   return [[OrderInfoPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
}
#pragma mark 扫码结果处理
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array{
    
    LBXScanResult *scanResult;
    if (array.count == 1) {
         scanResult = [array objectAtIndex:0];
        NSLog(@"strScanned=%@",scanResult.strScanned);
        
    }
    [self stopScan];
    
    [self reStartDevice];


    if (vilidRequest) {
        [vilidRequest cancel];
        vilidRequest = nil;
    }
    vilidRequest = [AssistantTask libraryManagevlidateWithUserId:self.strScannedUserId goodsSn:scanResult.strScanned successBlock:^(TRCResult * _Nonnull goodInfo) {
      
        if ([goodInfo.output isKindOfClass:[NSString class]]) {
        

        if (orderArray.count>0) {
        for (recordList *order in orderArray) {
            if ([order.goodsSn isEqualToString:scanResult.strScanned]) {
                order.lendingCount ++;
            }else
            {
                recordList *orderinfo = [[recordList alloc]init];
                orderinfo.goodsSn = scanResult.strScanned;
                orderinfo.lendingCount = 1;
                orderinfo.goodSnName = goodInfo.output;
                [orderArray addObject:orderinfo];
                
            }
        }
        }else
        {
            recordList *orderinfo = [[recordList alloc]init];
            orderinfo.goodsSn = scanResult.strScanned;
            orderinfo.lendingCount = 1;
            orderinfo.goodSnName = goodInfo.output;
            [orderArray addObject:orderinfo];
            
        }
            
        }
        [self.orderCountLable setText:[NSString stringWithFormat:@"%lu",(unsigned long)orderArray.count]];
        
        
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];

    }];
    
    
    
    
//    LBXScanResult *scanResult;

    
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
