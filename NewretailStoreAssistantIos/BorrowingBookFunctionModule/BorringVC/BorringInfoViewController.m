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

@end

@implementation BorringInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nextStep setTitle:@"不能再借了，知道了" forState:UIControlStateNormal];
    [self.nextStep setTitle:@"下一步" forState:UIControlStateNormal];

    // Do any additional setup after loading the view from its nib.
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
    
    //点击下一步到扫码页面借阅
    [self resetBackButtonTitleWith:@"扫码借阅" and:[UIColor whiteColor]];
    BorringBookScanViewController *booringVC= [[BorringBookScanViewController alloc]init];
    booringVC.stepNum = 2;
    [self.navigationController pushViewController:booringVC animated:YES];
    
}
@end
