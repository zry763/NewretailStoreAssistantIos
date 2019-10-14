//
//  HXSearchViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/19.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HXSearchViewController.h"
#import "HxSearchView.h"

@interface HXSearchViewController ()
@property (nonatomic ,strong) HxSearchView *searchView;


@end

@implementation HXSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem * flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    self.navigationItem.leftBarButtonItems = @[flexibleSpaceLeft];
    
//    self.navigationItem.titleView   self.searchView;

//    [self.navigationItem.titleView addSubview: self.searchView];
//    self.navigationItem.titleView  = self.searchView;
//    self.navigationItem.leftBarButtonItems = @[flexibleSpaceLeft];
    
//    UIButton *canceBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    [canceBt setTitle:@"取消" forState:UIControlStateNormal];
//    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithCustomView:self.searchView];
//    UIBarButtonItem *cancel  = [[UIBarButtonItem alloc]initWithCustomView:canceBt];
//    self.navigationItem.leftBarButtonItems = @[flexibleSpaceLeft,searchItem];

    //    self.navigationItem.leftBarButtonItem = searchItem;
//    self.navigationItem.rightBarButtonItem   = cancel;

//    self.navigationItem.titleView  = self.searchView;
 
    
//    [self.navigationItem.titleView addSubview:self.searchView];

    
    [self.view addSubview:self.searchView];
    
    
    // Do any additional setup after loading the view.
}
//-(HxSearchView *)searchView{
//    if (!_searchView) {
//        _searchView = [HxSearchView viewFromNib];
//    }
//    return _searchView;
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barStyle    = UIBarStyleDefault;
//
//    //如果不想让其他页面的导航栏变为透明 需要重置
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = YES;
//
//    self.navigationController.navigationBar.barStyle    = UIBarStyleBlackTranslucent;
//
//    //设置导航栏背景图片为一个空的image，这样就透明了
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    //
//
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
