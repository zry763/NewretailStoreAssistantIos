//
//  CustomNavigationController.m
//  Test123
//
//  Created by zry on 2019/9/4.
//  Copyright © 2019 zry. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = NO;
  


    // Do any additional setup after loading the view.
}


/* 某个页面导航栏透明,文字不透明
 - (void)viewWillAppear:(BOOL)animated
 {
 [super viewWillAppear:animated];
 //设置导航栏背景图片为一个空的image，这样就透明了
 [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
 //去掉透明后导航栏下边的黑边
 [self.navigationBar setShadowImage:[[UIImage alloc] init]];
 }
 
 - (void)viewWillDisappear:(BOOL)animated{
 
 //如果不想让其他页面的导航栏变为透明 需要重置
 [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
 [self.navigationController.navigationBar setShadowImage:nil];
 }
 */

+ (void)initialize {
    //appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //设置导航栏背景颜色
    [navigationBar setBarTintColor:[UIColor grayColor]];
    //设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:[UIColor whiteColor]];
    //设置标题栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:18]};
    [navigationBar setBackIndicatorImage:[UIImage imageNamed:@""]];
    [navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@""]];
    
//     //设置导航栏文字的主题
     NSShadow *shadow = [[NSShadow alloc]init];
     [shadow setShadowOffset:CGSizeZero];
     [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSShadowAttributeName : shadow}];
    
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
//     修改item上面的文字样式
     NSDictionary *dict =@{NSForegroundColorAttributeName : [UIColor whiteColor],NSShadowAttributeName : shadow};
     [barButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
     [barButtonItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    
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
