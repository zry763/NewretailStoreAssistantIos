//
//  HXStateViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HXStateViewController.h"
#import "HXTableViewCell.h"
#import "HXDetailsViewController.h"
#import "HXSearchViewController.h"

@interface HXStateViewController ()
{
    AssistantRequest *HxStateRequest;
    NSString *orderStatus;
    NSMutableArray *dataArray;
    NSString *uncompleteCount;
    NSString *completeCount;

}
@property(strong ,nonatomic) THCustomSegmentView *segmentView;
@property(assign,nonatomic) NSInteger selectIndex;
@property(strong ,nonatomic) UIButton *scrollTopBT;

@end

@implementation HXStateViewController

- (void)viewDidLoad {
    orderStatus = @"300";
    dataArray = [[NSMutableArray alloc]init];

    [super viewDidLoad];
    [self registerCellWithNibName:NSStringFromClass([HXTableViewCell class]) reuseIdentifier:NSStringFromClass([HXTableViewCell class])];

    self.selectIndex = 0;
    [self.pageInfo initData];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)setupSubviews{
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchSomeDetail)];
    self.navigationItem.rightBarButtonItem = searchItem;
    self.scrollToTopEnable = YES;
    [self.view addSubview:self.scrollTopBT];


    [self.scrollTopBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-50);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
    }];

}
-(void)searchSomeDetail{
    NSLog(@"搜索");
//    [self.navigationController presentViewController:[[HXSearchViewController alloc]init] animated:YES completion:nil];
    HXSearchViewController *searchVC  = [[HXSearchViewController alloc]init];
    searchVC.typeId = self.typeId;
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.scrollTopBT];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    HxStateRequest = nil;
    [self->dataArray removeAllObjects];

}
-(void)requestTableViewDataSource{
    if (HxStateRequest) {
        [HxStateRequest cancel];
        HxStateRequest = nil;
    }

    HxStateRequest = [AssistantTask hxListInfoWithTypeId:self.typeId orderStatus:orderStatus pageInfo:self.pageInfo successBlock:^(NSArray * _Nonnull orderArray, NSString * _Nonnull uncompleteCount, NSString * _Nonnull completeCount, PageModel * _Nonnull pageInfo) {
        
        self->uncompleteCount = uncompleteCount;
        self->completeCount = completeCount;
        if ([self.tableView.mj_header isRefreshing]) {
            [self->dataArray removeAllObjects];
        }
        self.pageInfo = pageInfo;
        [self->dataArray addObjectsFromArray:orderArray];
      
        [[NSNotificationCenter defaultCenter]postNotificationName:tableViewEndRefreshing object:nil];
        
        [self.tableView reloadData];
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];
        [[NSNotificationCenter defaultCenter]postNotificationName:tableViewEndRefreshing object:nil];
    }];
  
 
    
}


-(UIButton *)scrollTopBT{
    
    if (!_scrollTopBT) {
        _scrollTopBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scrollTopBT setImage:[UIImage imageNamed:@"backTop"] forState:UIControlStateNormal];
        [_scrollTopBT addTarget:self action:@selector(scrollToTop:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _scrollTopBT;
    
}
-(THCustomSegmentView *)segmentView{
    
    if (!_segmentView) {
        
        NSArray *titleArray = @[[NSString stringWithFormat:@"待核销%@",self.incompleteNum],[NSString stringWithFormat:@"已核销%@",self.completedNum]];
        self.segmentView = [[THCustomSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,40 ) withTitleArray:titleArray block:^(id segment, NSInteger index) {
            if (self.selectIndex == index) {
                return ;
            }
            self.selectIndex = index;
            NSLog(@"selectIndex=%ld",(long)index);
            if (index == 0) {
                self->orderStatus=@"300";
            }else
                self->orderStatus=@"301";
            [self.pageInfo initData];
            [self->dataArray removeAllObjects];

            [self requestTableViewDataSource];

        }];
        
        _segmentView.titleSelectColor = [TRCColor colorFromHexCode:@"#D33A31"];
        _segmentView.indictorColor =[TRCColor colorFromHexCode:@"#D33A31"];
        _segmentView.isShowButtomLine = YES;
    }
    return _segmentView;
}
- (void)setupTableView {
    [super setupTableView];
    
    [self.view addSubview:self.segmentView];


    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.view).with.offset(45);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXTableViewCell class]) forIndexPath:indexPath];
    ProjectItemListModel  *listModel = [dataArray objectAtIndex:indexPath.row];
    [cell setUpWithModel:listModel];
    cell.hxItemStateImage.hidden = YES;


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self resetBackButtonTitleWith:@"预约详情"and:[UIColor clearColor]];
    HXDetailsViewController *hxDetailVC =[[HXDetailsViewController alloc]init];
    ProjectItemListModel  *listModel = [dataArray objectAtIndex:indexPath.row];

    hxDetailVC.reservationCode = listModel.reservationCode;
    hxDetailVC.typeId = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:listModel.typeId]];
    if (listModel.orderStatus == 300) {//待核销
          hxDetailVC.isDisplay = NO;
      }else
          hxDetailVC.isDisplay = YES;


        
    [self.navigationController pushViewController:hxDetailVC animated:YES];
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
