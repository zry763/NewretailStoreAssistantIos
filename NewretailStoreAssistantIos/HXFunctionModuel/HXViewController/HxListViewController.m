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

extern UserInfoModel *infomodel;

@interface HxListViewController ()
{
    
    AssistantRequest *itemRequest;
    
    NSArray *projectItemArray;
}



@end

@implementation HxListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_footer = nil;
    [self registerCellWithNibName:NSStringFromClass([YYListTableViewCell class]) reuseIdentifier:NSStringFromClass([YYListTableViewCell class])];

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    itemRequest = nil;
}
-(void)requestTableViewDataSource{
    
    if (itemRequest) {
        itemRequest = nil;
    }
    itemRequest = [AssistantTask hxListInfoWithToken:infomodel.token successBlock:^(NSArray * _Nonnull projectItemModelArray) {
        
        self->projectItemArray = [projectItemModelArray copy];
        [self.tableView reloadData];
        [[NSNotificationCenter defaultCenter]postNotificationName:tableViewEndRefreshing object:nil];

    } failureBlock:^(TRCResult *result) {
        
    }];
    
}
    
    


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self->projectItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YYListTableViewCell *yylistCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YYListTableViewCell class])];
    ProjectItemModel *itemModel = [self->projectItemArray objectAtIndex:indexPath.row];
    
    [yylistCell setUpWithModel:itemModel];
    
    TRC_BLOCK_WEAK_SELF
    //去核销
    yylistCell.yyHXProject = ^(NSInteger index) {
        NSString  *backTitle =@"扫码核销";
        [weakSelf resetBackButtonTitleWith:backTitle and:[UIColor whiteColor]];
        HXScanViewController *scanVC =[[HXScanViewController alloc]init];
        scanVC.typeId = itemModel.typeId;
        [weakSelf.navigationController pushViewController:scanVC animated:YES];
        
        
    };
    //去预约列表
    yylistCell.yylistProject = ^(NSInteger index) {
        NSString  *backTitle =@"预约列表";
        [weakSelf resetBackButtonTitleWith:backTitle and:[UIColor clearColor]];
        HXStateViewController *HXStateVC =[[HXStateViewController alloc]init];
        HXStateVC.typeId = itemModel.typeId;
        [weakSelf.navigationController pushViewController:HXStateVC animated:YES];
        
    };
    
    
    return yylistCell;
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
