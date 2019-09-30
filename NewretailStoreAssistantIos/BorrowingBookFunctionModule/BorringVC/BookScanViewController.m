//
//  BookScanViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BookScanViewController.h"
#import "BorringProcessView.h"

@interface BookScanViewController ()
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
