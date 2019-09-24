//
//  BaseViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/17.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//从容器顶部开始布局UIRectEdgeNone
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    NSLog(@"stepNum===%@",[NSNumber numberWithBool:self.borringOrReturn]);
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
    [self setupSubviews];
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];


    if (!self.navigationController) {
        return;
    }

    if (self.navigationBarHidden) {

        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }else
    {
        [self.navigationController setNavigationBarHidden:NO animated:NO];

    }
}
#pragma mark - Public
#pragma mark 设置子界面（需重写）
- (void)setupSubviews {
    
}

//
//#pragma mark 导航条添加返回按钮
//- (void)addNavigationActionWithBack {
//    
//    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
//    
//    if (@available(iOS 11.0, *)) {
//        
//        self.navigationItem.leftBarButtonItem = barButtonItem;
//        
//    } else {
//        
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -16; // it was -6 in iOS 6
//        
//        self.navigationItem.leftBarButtonItems = @[negativeSpacer, barButtonItem];
//    }
//}
//- (UIButton *)backButton {
//
//    if (!_backButton) {
//
//        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _backButton.frame = CGRectMake(0.f, 0.f, 60.f, 40.f);
//        [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
//        [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
//        [_backButton setTitleColor:TRC353535 forState:UIControlStateNormal];
//        [_backButton setTitleColor:TRC525252 forState:UIControlStateHighlighted];
//        _backButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_backButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    }
//
//    return _backButton;
//}

#pragma mark 点击返回按钮后调用
- (void)backButtonPressed {
    
  
}


#pragma mark - Public Methods
#pragma mark 请求列表数据（需重写）
- (void)requestTableViewDataSource {
    
}

-(void)resetBackButtonTitleWith:(NSString * )backTitle and:(UIColor *)color
{
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title =backTitle;
    [backBtnItem setTitlePositionAdjustment:UIOffsetMake(0, -15) forBarMetrics:UIBarMetricsDefault];
    if (color != [UIColor clearColor]) {
        NSDictionary *dict =@{NSForegroundColorAttributeName : color};
        
        [backBtnItem setTitleTextAttributes:dict forState:UIControlStateNormal];
        [backBtnItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    }

    self.navigationItem.backBarButtonItem = backBtnItem;
}

-(StepModel *)stepModel
{
    if (!_stepModel) {
        _stepModel = [[StepModel alloc]init];
        
    }
    return _stepModel;
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
