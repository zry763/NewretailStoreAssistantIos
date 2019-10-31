//
//  CheckBookViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/25.
//  Copyright © 2019 zry. All rights reserved.
//

#import "CheckBookViewController.h"
#import "BorringProcessView.h"
#import "CheckBookTableViewCell.h"
#import "ReturnBookHeaderView.h"
#import "BookResultDetailViewController.h"

@interface CheckBookViewController ()
{
    AssistantRequest *returnBookConfirmRequest;
    
}
@property (strong ,nonatomic) BorringProcessView *processView;
@property (strong ,nonatomic) ReturnBookHeaderView *checkListHeaderView;
@end

@implementation CheckBookViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellWithNibName:NSStringFromClass([CheckBookTableViewCell class]) reuseIdentifier:NSStringFromClass([CheckBookTableViewCell class])];
    self.tableView.mj_header = nil;
    // Do any additional setup after loading the view.
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
    
    UIButton *confirmReturnBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmReturnBT setTitle:@"经核对无缺失和损坏，确定归还" forState:UIControlStateNormal];
    [confirmReturnBT.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [confirmReturnBT setBackgroundColor:[TRCColor colorFromHexCode:@"#D33A31"]];
    [confirmReturnBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmReturnBT addTarget:self action:@selector(confirmReturnBook) forControlEvents:UIControlEventTouchUpInside];
    confirmReturnBT.layer.cornerRadius = 22;
    confirmReturnBT.layer.masksToBounds =YES;
    [self.view addSubview:confirmReturnBT];
    [confirmReturnBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).with.offset(30);
        make.bottom.equalTo(self.view).with.offset(-30);
        make.height.equalTo(@(44));
    }];
    
    
    
}
-(void)confirmReturnBook{
    
    [self resetBackButtonTitleWith:@"图书归还" and: [UIColor clearColor]];
    BookResultDetailViewController *bookResultVC =[[BookResultDetailViewController alloc]init];
    bookResultVC.stepNum = 3;
    [bookResultVC.goonBorringBT setTitle:@"继续归还" forState:UIControlStateNormal];
    
    if (returnBookConfirmRequest) {
        [returnBookConfirmRequest cancel];
        returnBookConfirmRequest = nil;
        
    }
    returnBookConfirmRequest = [AssistantTask libraryManageReturnBookWithBookId:[NSString stringWithFormat:@"%ld",(long)self.returnRecordInfo.recordID] successBlock:^(TRCResult *resultInfo) {
        if (resultInfo.responseCode == 0) {
            [self.navigationController pushViewController: bookResultVC animated:YES];

        }
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];

    }];
    NSLog(@"确认归还");
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
        _checkListHeaderView.headerTitle.text = @"本次记录明细";
        _checkListHeaderView.dataCount.text =@"";
        _checkListHeaderView.describeLable.text =@"请确保一次归还所有借阅图书，不支持部分归还";
    }
    return _checkListHeaderView;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.returnRecordInfo.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckBookTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CheckBookTableViewCell class]) forIndexPath:indexPath];

    ReturnBookRecordInfo *bookInfo = [self.returnRecordInfo.list objectAtIndex:indexPath.row];
    
    [cell setUpWithModel:bookInfo];
    

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
