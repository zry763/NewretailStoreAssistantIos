//
//  BookDetailViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BookResultDetailViewController.h"
#import "BorringResultInfoView.h"
#import "BorringProcessView.h"

@interface BookResultDetailViewController ()
@property (strong ,nonatomic)BorringResultInfoView *borringResultView;
@property (strong ,nonatomic) BorringProcessView *processView;


@end

@implementation BookResultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.goonBorringBT.layer.cornerRadius = 22;
    self.goonBorringBT.layer.masksToBounds = YES;
    self.goonBorringBT.layer.borderColor = [TRCColor colorFromHexCode:@"#D4D4D4"].CGColor;
    self.goonBorringBT.layer.borderWidth = 1;
    self.goHomeBT.layer.cornerRadius = 22;
    self.goHomeBT.layer.masksToBounds = YES;
  
    // Do any additional setup after loading the view from its nib.
}

-(void)setupSubviews{
    [self.bookContainView addSubview:self.borringResultView];
    [self.borringResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bookContainView);
    }];
    
    [self.view addSubview:self.processView];
    TRC_BLOCK_WEAK_SELF
    [self.processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(15);
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        
    }];
    [self.processView setupViewWithModel:self.stepModel];
 
    

}

-(BorringResultInfoView *)borringResultView{
    if (!_borringResultView) {
        _borringResultView = [BorringResultInfoView viewFromNib];
    }
    return _borringResultView;
}





-(BorringProcessView *)processView{
    if (!_processView) {
        _processView = [BorringProcessView viewFromNib];
        _processView.backgroundColor =[TRCColor colorFromHexCode:@"#FAFAFA"];
        [_processView.firstStep setTextColor:[TRCColor colorFromHexCode:@"#666666"]];
        [_processView.secondStep setTextColor:[TRCColor colorFromHexCode:@"#666666"]];
        [_processView.thirdStep setTextColor:[TRCColor colorFromHexCode:@"#666666"]];
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

- (IBAction)goonBorringBook:(id)sender {
    
    NSLog(@"继续借还书");
}

- (IBAction)goHomeView:(id)sender {
    
    NSLog(@"返回首页");
}
@end
