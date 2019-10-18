//
//  HXDetailsViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HXDetailsViewController.h"
#import "HXfootView.h"
#import "YYhxItemTableViewCell.h"
#import "YYhxItemDescribleTableViewCell.h"
#import "YYhxItemDetailsTableViewCell.h"

@interface HXDetailsViewController ()
{
    
    AssistantRequest *HxStateDetailInfoRequest;
    AssistantRequest *HxconfirmRequest;
    hxStateDetailInfoModel *detailInfoModel;


}
@property(strong ,nonatomic) HXfootView *hxfootView;
@property(strong ,nonatomic) YYhxItemTableViewCell *hxItemCell;
@property(strong ,nonatomic) YYhxItemDetailsTableViewCell *hxItemDetailsCell;
@property(strong ,nonatomic) YYhxItemDescribleTableViewCell *hxItemDescribleCell;

@property(strong ,nonatomic) UIButton *hxConfirmBt;


@end

@implementation HXDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.mj_footer = nil;

    // Do any additional setup after loading the view.
}
-(void)setupSubviews{
    
    if (self.isDisplay) {
        [self.view addSubview:self.hxfootView];
        [self.hxfootView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(10);
            make.right.equalTo(self.view).with.offset(-10);
            make.bottom.equalTo(self.view).with.offset(-20);
        }];
    }
        
    if (self.confirmBtDisplay) {
        [self.view addSubview:self.hxConfirmBt];
        [self.hxConfirmBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(70);
            make.bottom.equalTo(self.view).with.offset(-35);
            make.centerX.equalTo(self.view);
            make.height.equalTo(@(44));
            
        }];
    }
}

-(void)requestTableViewDataSource
{
    if (HxStateDetailInfoRequest) {
        [HxStateDetailInfoRequest cancel];
        HxStateDetailInfoRequest = nil;
    }
    HxStateDetailInfoRequest =  [AssistantTask hxItemDetailInfoWithreservationCode:self.reservationCode successBlock:^(hxStateDetailInfoModel * _Nonnull DetailInfoModel) {
        self->detailInfoModel =DetailInfoModel;
        
        if (DetailInfoModel.orderStatus == 301) {//=已核销
            [self.hxfootView setupViewWithModel:DetailInfoModel];

        }

        [[NSNotificationCenter defaultCenter]postNotificationName:tableViewEndRefreshing object:nil];
        [self.tableView reloadData];
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];
        [[NSNotificationCenter defaultCenter]postNotificationName:tableViewEndRefreshing object:nil];
    }];
    
    
    
    
    
}
                                
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    if (self.isDisplay) {
        [self.view bringSubviewToFront:self.hxfootView];

    }else
    [self.view bringSubviewToFront:self.hxConfirmBt];

}

-(UIButton *)hxConfirmBt{
    if (!_hxConfirmBt) {
        _hxConfirmBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _hxConfirmBt.backgroundColor = [TRCColor colorFromHexCode:@"#D33A31"];
        [_hxConfirmBt.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_hxConfirmBt setTitle:@"确认核销" forState:UIControlStateNormal];
        [_hxConfirmBt addTarget:self action:@selector(confirmItem) forControlEvents:UIControlEventTouchUpInside];
        
        _hxConfirmBt.layer.cornerRadius = 22;
        _hxConfirmBt.layer.masksToBounds = YES;
    }
    return _hxConfirmBt;
}

-(void)confirmItem{
    if (HxconfirmRequest) {
        [HxconfirmRequest cancel];
         
    }
    HxconfirmRequest = [AssistantTask hxConfirmItemWithTypeId:self.typeId reservationCode:self.reservationCode successBlock:^(TRCResult *result) {
        
        if (result.responseCode == 0) {
            [self.view makeToast:@"核销成功" duration:1 position:CSToastPositionBottom];
        }else
            [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];

            
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];

    }];
    
    
}
-(HXfootView *)hxfootView{
    if (!_hxfootView) {
        _hxfootView = [HXfootView viewFromNib];
        
    }
    return _hxfootView;
}

-(YYhxItemTableViewCell *)hxItemCell{
    if (!_hxItemCell) {
        [self registerCellWithNibName:NSStringFromClass([YYhxItemTableViewCell class]) reuseIdentifier:NSStringFromClass([YYhxItemTableViewCell class])];
        
        _hxItemCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YYhxItemTableViewCell class])];
        
    }
    return _hxItemCell;
}
-(YYhxItemDetailsTableViewCell *)hxItemDetailsCell{
    if (!_hxItemDetailsCell) {
        [self registerCellWithNibName:NSStringFromClass([YYhxItemDetailsTableViewCell class]) reuseIdentifier:NSStringFromClass([YYhxItemDetailsTableViewCell class])];
        
        _hxItemDetailsCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YYhxItemDetailsTableViewCell class])];
    }
    return _hxItemDetailsCell;
}
-(YYhxItemDescribleTableViewCell *)hxItemDescribleCell{
    if (!_hxItemDescribleCell) {
        [self registerCellWithNibName:NSStringFromClass([YYhxItemDescribleTableViewCell class]) reuseIdentifier:NSStringFromClass([YYhxItemDescribleTableViewCell class])];
        
        _hxItemDescribleCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YYhxItemDescribleTableViewCell class])];
    }
    return _hxItemDescribleCell;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (detailInfoModel.goodsList.count == 0) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        [self.hxItemCell setUpWithModel:detailInfoModel];
        
        return self.hxItemCell;
    }else
    if (indexPath.row == 1) {
        [self.hxItemDetailsCell setUpWithModel:detailInfoModel];

        return self.hxItemDetailsCell;

    }else
    if (indexPath.row == 2) {
        [self.hxItemDescribleCell setUpWithModel:detailInfoModel];
        return self.hxItemDescribleCell;

    }
    return [UITableViewCell new];
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
