//
//  HXSearchViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HXSearchViewController.h"
#import "HXDetailsViewController.h"
#import "HXTableViewCell.h"

@interface HXSearchViewController ()
{
    AssistantRequest *searchRequest;
    NSMutableArray *dataArray;

}
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation HXSearchViewController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.navigationItem setHidesBackButton:YES];
    [self setBarButtonItem];
    self.tableView.emptyDataSetSource   = nil;
    self.tableView.emptyDataSetDelegate = nil;
    [self.pageInfo initData];
    [self registerCellWithNibName:NSStringFromClass([HXTableViewCell class]) reuseIdentifier:NSStringFromClass([HXTableViewCell class])];

    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}
- (void)setBarButtonItem
{
    //隐藏导航栏上的返回按钮
    [self.navigationItem setHidesBackButton:YES];
    //用来放searchBar的View
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(15, 7, self.view.frame.size.width, 30)];
    //创建searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame)-15, 30)];
    //默认提示文字
    searchBar.placeholder = @"输入会员手机号、活动名称搜索";
    searchBar.showsCancelButton = YES;

    //代理
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;

    [titleView addSubview:searchBar];
    [searchBar setTintColor:[TRCColor colorFromHexCode:@"#6194D8"]];
    
    self.searchBar = searchBar;

    self.navigationItem.titleView = titleView;
}


#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;



}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchRequestWithContent:searchBar.searchTextField.text];

    NSLog(@"SearchButton=%@",searchBar.searchTextField.text);
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;

}


-(void)searchRequestWithContent:(NSString *)content
{
    
    if (content) {
        
        if (searchRequest) {
            [searchRequest cancel];
            searchRequest = nil;
        }
        searchRequest  = [AssistantTask hxSearchItemInfoWithTypeId:self.typeId content:content pageInfo:self.pageInfo successBlock:^(NSArray * _Nonnull orderArray, PageModel * _Nonnull pageInfo) {
            self.pageInfo = pageInfo;
            [self->dataArray addObjectsFromArray:orderArray];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter]postNotificationName:tableViewEndRefreshing object:nil];

        } failureBlock:^(TRCResult *result) {
            [self.view makeToast:result.responseContent duration:1 position:CSToastPositionCenter];
            [[NSNotificationCenter defaultCenter]postNotificationName:tableViewEndRefreshing object:nil];
        }];
    }
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
    cell.hxItemStateImage.hidden = NO;


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self resetBackButtonTitleWith:@"预约详情"and:[UIColor clearColor]];
    HXDetailsViewController *hxDetailVC =[[HXDetailsViewController alloc]init];
    ProjectItemListModel  *listModel = [dataArray objectAtIndex:indexPath.row];

    hxDetailVC.reservationCode = listModel.reservationCode;
    hxDetailVC.typeId = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:listModel.typeId]];
    if (listModel.orderStatus ==300) {//待核销
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
