//
//  AssociateMemberViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "AssociateMemberViewController.h"
#import "BorringProcessView.h"
#import "BorringInfoTableViewCell.h"
#import "ReturnBookHeaderView.h"
#import "CheckBookViewController.h"

@interface AssociateMemberViewController ()
{
    AssistantRequest *returnBookListRequest;
    NSString *vipId;
    VipReturnInfoModel *returnRecordModel;
}
@property (strong ,nonatomic) BorringProcessView *processView;
@property (strong ,nonatomic) ReturnBookHeaderView *checkListHeaderView;


@end

@implementation AssociateMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellWithNibName:NSStringFromClass([BorringInfoTableViewCell class]) reuseIdentifier:NSStringFromClass([BorringInfoTableViewCell class])];
    // Do any additional setup after loading the view.
}

-(void)requestTableViewDataSource{
    
    if (returnBookListRequest) {
        [returnBookListRequest cancel];
        returnBookListRequest = nil;
    }
    returnBookListRequest = [AssistantTask libraryManageReturnInfoWithUserId:self.strScannedUserId successBlock:^(VipReturnInfoModel * _Nonnull returnInfoModel) {
        self->returnRecordModel =returnInfoModel;
        [self.tableView reloadData];
        
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];

    }];
    
}
-(void)setupTableView{
    [super setupTableView];
    [self.view addSubview:self.processView];
    TRC_BLOCK_WEAK_SELF
    [self.processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(15);
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        
    }];
    [self.processView setupViewWithModel:self.stepModel];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.processView.mas_bottom).with.offset(20);
        
    }];
    
    
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

-(ReturnBookHeaderView *)checkListHeaderView{
    if (!_checkListHeaderView) {
        _checkListHeaderView = [ReturnBookHeaderView viewFromNib];
        _checkListHeaderView.headerTitle.text = @"选择借阅记录";
        _checkListHeaderView.dataCount.text =@"";
        _checkListHeaderView.describeLable.text =@"已定损的不显示，如需操作请联系店长";

    }
    return _checkListHeaderView;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return returnRecordModel.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BorringInfoTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BorringInfoTableViewCell class]) forIndexPath:indexPath];
    ReturnRecords *returnRecord = [returnRecordModel.records objectAtIndex:indexPath.row];

    cell.bookreturn = ^{
        CheckBookViewController *checkBookVC =[[CheckBookViewController alloc]init];
        checkBookVC.stepNum = 2;
        checkBookVC.returnRecordInfo = returnRecord;
        
        [self.navigationController pushViewController:checkBookVC animated:YES];
        
        NSLog(@"归还图书");
    };

    [cell setUpWithModel:returnRecord];
    

    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    
    return self.checkListHeaderView;

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
