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
    NSLog(@"stepNum===%ld",(long)self.stepNum);
    NSLog(@"stepNum===%ld",(long)self.stepNum);
    
    if (self.stepNum) {
        self.stepModel.currentStep = self.stepNum;
        
    }else
        self.stepModel.currentStep =1;
    if (self.borringOrReturn) {
        self.stepModel.firstSteptTitle = @"1.关联会员";
        self.stepModel.secondSteptTitle = @"2.扫码借书";
        self.stepModel.thirdSteptTitle = @"3.完成借阅";
        
    }else{
        self.stepModel.firstSteptTitle = @"1.关联会员";
        self.stepModel.secondSteptTitle = @"2.图书核对";
        self.stepModel.thirdSteptTitle = @"3.完成归还";
    }
    // Do any additional setup after loading the view.
}
-(StepModel *)stepModel
{
    if (!_stepModel) {
        _stepModel = [[StepModel alloc]init];
 
    }
    return _stepModel;
}

-(void)addSomeSubviews{
    
    [super addSomeSubviews];

    [self.qRScanView addSubview:self.processView];
    TRC_BLOCK_WEAK_SELF

    [self.processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.qRScanView).with.offset(15);
        make.centerX.equalTo(weakSelf.qRScanView);
        make.top.equalTo(weakSelf.qRScanView).with.offset(64);

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
