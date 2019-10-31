//
//  BaseTableViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UITableView+FooterManager.h"

@interface BaseTableViewController ()
@property(nonatomic ,strong) UIActivityIndicatorView *activityView;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewEndRefresh) name:tableViewEndRefreshing object:nil];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.tableView.emptyDataSetSource   = self;
     self.tableView.emptyDataSetDelegate = self;
    self.tableView.autoHideMjFooter = YES;
 
    // 去除最后的分割钱 plain
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor clearColor];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self setupTableView];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
    }
    
    
    
}
- (void)requestTableViewDataSource
{
}

-(void)tableViewEndRefresh{
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
        

    }
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
        if (self.pageInfo.currPage == self.pageInfo.totalPage ) {
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;

        }
     }
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (PageModel *)pageInfo {
    
    if (!_pageInfo) {
        
        _pageInfo = [[PageModel alloc] init];
    }
    
    return _pageInfo;
}

#pragma mark - Public
#pragma mark 配置tableView
- (void)setupTableView {
    
    self.tableView.sectionFooterHeight = 20;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
  
    
    
    // 默认的下拉刷新和上拉加载
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageInfo.currPage = 1;
        [self requestTableViewDataSource];
        // 这个地方是网络请求的处理
  
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.pageInfo.currPage<self.pageInfo.totalPage) {
            self.pageInfo.currPage++;
            [self requestTableViewDataSource];
        }else
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;

        
        // 这个地方是网络请求的处理
    }];


    // 注册默认的cell
    NSString *className = @"BaseTableViewCell";
    [self registerCellWithClassName:className reuseIdentifier:className];
}


#pragma mark 通过nib文件名称注册cell
- (void)registerCellWithNibName:(NSString *)nibName reuseIdentifier:(NSString *)identifier {
    
    UINib * nib = [UINib nibWithNibName:nibName bundle:nil];
    
    if (!nib) {
        return;
    }
    
    self.defaultCellReuseIdentifier = identifier;
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
}


#pragma mark 通过类名注册cell
- (void)registerCellWithClassName:(NSString *)className reuseIdentifier:(NSString *)identifier {
    
    Class class = NSClassFromString(className);
    
    if (!class) {
        return;
    }
    
    self.defaultCellReuseIdentifier = identifier;
    [self.tableView registerClass:class forCellReuseIdentifier:identifier];
}


#pragma mark scrollView内容移动到顶层
- (void)scrollToTop:(BOOL)animated {
    
    if (!self.scrollToTopEnable)
        return;
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:animated];
}


#pragma mark scrollView内容移动到底层
- (void)scrollToBottom:(BOOL)animated {
    
    if (self.tableView.contentSize.height < self.tableView.frame.size.height)
        return;
    
    NSUInteger sectionCount = [self.tableView numberOfSections];
    
    if (sectionCount)
    {
        NSUInteger rowCount = [self.tableView numberOfRowsInSection:0];
        
        if (rowCount)
        {
            NSUInteger i[2] = {0, rowCount - 1};
            NSIndexPath * indexPath = [NSIndexPath indexPathWithIndexes:i length:2];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        }
    }
}



#pragma mark 请求列表数据（需重写）


#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger row = [indexPath row];

    BaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BaseTableViewCell"];

    if ([self.dataSource count] > row) {

        id model = [self.dataSource objectAtIndex:row];
        [cell setUpWithModel:model];
    }


    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark  DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    
    return [UIImage imageNamed:@"NoContent"];

}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{

    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc]initWithString:@"暂无内容"];
    UIFont *font = [UIFont systemFontOfSize:15.0];

    [titleStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, titleStr.length)];
    [titleStr addAttribute:NSForegroundColorAttributeName value:[TRCColor colorFromHexCode:@"#353535"] range:NSMakeRange(0, titleStr.length)];

    return titleStr;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    self.tableView.contentOffset = CGPointZero;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    
    if ([self.activityView isAnimating]) {
        [self.activityView stopAnimating];
        UIView *nocontentView = [[UIView alloc]initWithFrame:CGRectZero];
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NoContent"]];
        UILabel *deslable = [[UILabel alloc]init];
        [deslable setText:@"暂无内容"];
        [nocontentView addSubview: imageview];
        [nocontentView addSubview:deslable];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nocontentView).offset(-50);
            make.centerX.equalTo(nocontentView);
        }];
        [deslable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(nocontentView);
            make.top.equalTo(imageview.mas_bottom).offset(10);
        }];
        
        return nocontentView;
        
    }else
    {
        NSLog(@"customViewForEmptyDataSet");
        UIView *custview = [[UIView alloc]initWithFrame:CGRectZero];
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [custview addSubview:self.activityView];
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(custview);
            make.centerY.equalTo(custview);
        }];
        
        [ self.activityView startAnimating];
        
        
        return  custview;
        
    }
    
    
    
}



-(UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

#if 0
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#endif
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
