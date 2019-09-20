//
//  BaseTableViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

/**
 *  列表界面
 */
@property (nonatomic, strong) UITableView *tableView;


/**
 *  列表的显示风格
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;


/**
 *  是否支持滚动到顶部
 */
@property (nonatomic, assign) BOOL scrollToTopEnable;


/**
 *  默认的cell重用标示符
 */
@property (nonatomic, strong) NSString *defaultCellReuseIdentifier;


/**
 *  列表数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  配置tableView
 */
- (void)setupTableView;


/**
 *  通过nib文件名称注册cell
 *
 *  nibName    nib文件的名称
 *  identifier 重用标示符
 */
- (void)registerCellWithNibName:(NSString *)nibName reuseIdentifier:(NSString *)identifier;


/**
 *  通过类名注册cell
 *
 *  className  类名
 *  identifier 重用标示符
 */
- (void)registerCellWithClassName:(NSString *)className reuseIdentifier:(NSString *)identifier;


/**
 *  下拉刷新（开启自定义刷新功能或者开启TRCPullToRefresh都将调用此方法进行下拉刷新）
 */
- (void)pullToRefresh;

/**
 *  请求列表数据（需重写）
 */
- (void)requestTableViewDataSource;
/**
 *  scrollView内容移动到顶层
 *
 *  animated 是否开启动画效果
 */
- (void)scrollToTop:(BOOL)animated;


/**
 *  scrollView内容移动到底层
 *
 *  animated 是否开启动画效果
 */
- (void)scrollToBottom:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
