//
//  BookScanViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BookScanViewController.h"
#import "BorringProcessView.h"
#import "StepModel.h"

@interface BookScanViewController ()
@property (strong ,nonatomic) BorringProcessView *processView;
@property (strong ,nonatomic) StepModel   *stepModel;

@end

@implementation BookScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}
-(StepModel *)stepModel
{
    if (!_stepModel) {
        _stepModel = [[StepModel alloc]init];
        _stepModel.currentStep =1;
        if (self.borringOrReturn) {
            _stepModel.firstSteptTitle = @"1.关联会员";
            _stepModel.secondSteptTitle = @"2.扫码借书";
            _stepModel.thirdSteptTitle = @"3.完成借阅";

        }else{
            _stepModel.firstSteptTitle = @"1.关联会员";
            _stepModel.secondSteptTitle = @"2.图书核对";
            _stepModel.thirdSteptTitle = @"3.完成归还";
        }
 
    }
    return _stepModel;
}

-(void)addSomeSubviews{
    
    [super addSomeSubviews];

    [self.view addSubview:self.processView];
    TRC_BLOCK_WEAK_SELF

    [self.processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(15);
        make.right.equalTo(weakSelf.view).with.offset(-15);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(64);
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
