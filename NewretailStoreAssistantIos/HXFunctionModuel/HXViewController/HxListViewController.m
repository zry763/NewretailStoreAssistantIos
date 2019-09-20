//
//  HxListViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HxListViewController.h"
#import "YYListTableViewCell.h"
#import "HXStateViewController.h"
#import "HXScanViewController.h"


@interface HxListViewController ()
@property(strong ,nonatomic) YYListTableViewCell *yylistCell;



@end

@implementation HxListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(YYListTableViewCell *)yylistCell{
    if (!_yylistCell) {
        
        [self registerCellWithNibName:NSStringFromClass([YYListTableViewCell class]) reuseIdentifier:NSStringFromClass([YYListTableViewCell class])];
        _yylistCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YYListTableViewCell class])];
        TRC_BLOCK_WEAK_SELF
        //去核销
        _yylistCell.yyHXProject = ^(NSInteger index) {
            NSString  *backTitle =@"扫码核销";
            [weakSelf resetBackButtonTitleWith:backTitle and:[UIColor whiteColor]];
            HXScanViewController *scanVC =[[HXScanViewController alloc]init];
            [weakSelf.navigationController pushViewController:scanVC animated:YES];

            
        };
        //去预约列表
        _yylistCell.yylistProject = ^(NSInteger index) {
            NSString  *backTitle =@"预约列表";
            [weakSelf resetBackButtonTitleWith:backTitle and:[UIColor clearColor]];

            [weakSelf.navigationController pushViewController:[[HXStateViewController alloc]init] animated:YES];
            
        };
        
        
    }
    return _yylistCell;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    
    return self.yylistCell;
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
