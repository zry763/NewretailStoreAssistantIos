//
//  BorringHomeViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/20.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringHomeViewController.h"
#import "BookScanViewController.h"

@interface BorringHomeViewController ()
@property (strong ,nonatomic) BookScanViewController *bookScanVC;
@end

@implementation BorringHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)borringBook:(id)sender {
    
    UITapGestureRecognizer *gest = (UITapGestureRecognizer *)sender;
    
    
    UIView *desView = gest.view;
    NSLog(@"%ld",(long)desView.tag);
    if (desView.tag == 100) {
        self.bookScanVC.borringOrReturn = YES;
        [self resetBackButtonTitleWith:@"图书借阅" and: [UIColor whiteColor]];

    }else
    {
    self.bookScanVC.borringOrReturn = NO;
    [self resetBackButtonTitleWith:@"图书归还" and: [UIColor whiteColor]];
    }

    
    [self.navigationController pushViewController:self.bookScanVC animated:YES];
    
}

-(BookScanViewController *)bookScanVC{
    if (!_bookScanVC) {
        _bookScanVC = [[BookScanViewController alloc]init];
    }
    return _bookScanVC;
}
@end
