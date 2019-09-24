//
//  BorringHomeViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/20.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringHomeViewController.h"
#import "BookScanViewController.h"


#import "BorringBookScanViewController.h"
#import "AssociateMemberViewController.h"
@interface BorringHomeViewController ()
- (IBAction)pushAssocationVC:(id)sender;
- (IBAction)扫码借书按钮:(id)sender;
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
    BookScanViewController *bookScanVC = [[BookScanViewController alloc]init];

    
    UIView *desView = gest.view;
    NSLog(@"%ld",(long)desView.tag);
    if (desView.tag == 100) {
        bookScanVC.borringOrReturn = YES;
        [self resetBackButtonTitleWith:@"图书借阅" and: [UIColor whiteColor]];

    }else
    {
        bookScanVC.borringOrReturn = NO;

    [self resetBackButtonTitleWith:@"图书归还" and: [UIColor whiteColor]];
    }

    
    [self.navigationController pushViewController:bookScanVC animated:YES];
    
}



- (IBAction)扫码借书按钮:(id)sender {
    
    [self.navigationController pushViewController:[[BorringBookScanViewController alloc]init] animated:YES];
    
}
- (IBAction)pushAssocationVC:(id)sender {
        [self.navigationController pushViewController:[[AssociateMemberViewController alloc]init] animated:YES];
}
@end
