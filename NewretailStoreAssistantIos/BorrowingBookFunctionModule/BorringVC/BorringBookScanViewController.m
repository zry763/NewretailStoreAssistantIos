//
//  BorringBookScanViewController.m
//  NewretailStoreAssistantIos
//
//  Created by Z-Mac on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringBookScanViewController.h"

@interface BorringBookScanViewController ()


@property (strong ,nonatomic) UIButton *scaninputBT;//输码借阅
@property(strong ,nonatomic) UIButton *confirmBt;//确认借阅
@property(strong ,nonatomic) UIButton *orderBt;//确认借阅
@property(strong ,nonatomic) UILabel *orderCountLable;//确认借阅

@end

@implementation BorringBookScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
}

//确认借阅
-(UIButton *)confirmBt{
    if (!_confirmBt) {
        _confirmBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBt.backgroundColor = [TRCColor colorFromHexCode:@"#D33A31"];
        [_confirmBt.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_confirmBt setTitle:@"确认借阅" forState:UIControlStateNormal];
        _confirmBt.layer.cornerRadius = 22;
        _confirmBt.layer.masksToBounds = YES;
    }
    return _confirmBt;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
