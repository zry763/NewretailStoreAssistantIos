//
//  BaseTableViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

#pragma mark - Public
#pragma mark 配置tableView
- (void)setupTableView {
    
    self.tableView.sectionFooterHeight = 20;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
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
#pragma mark 下拉刷新
- (void)pullToRefresh {
    
    [self requestTableViewDataSource];
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
- (void)requestTableViewDataSource {
    
    
}


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
