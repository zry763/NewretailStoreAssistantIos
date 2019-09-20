//
//  BaseViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/17.
//  Copyright © 2019 zry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  返回按钮点击后的回调
 */
@interface BaseViewController : UIViewController

/**
 *  状态栏的风格
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;


/**
 *  状态栏的隐藏状态
 */
@property (nonatomic, assign) BOOL statusBarHidden;


/**
 *  导航条的隐藏状态
 */
@property (nonatomic, assign) BOOL navigationBarHidden;


///**
// *  自定义返回按钮
// */
//@property (nonatomic, strong) UIButton *backButton;


/**
 *  设置子界面（需重写）
 */
- (void)setupSubviews;


///**
// *  导航条添加返回按钮
// */
//- (void)addNavigationActionWithBack;
///**
// *  点击返回按钮后调用
// */
//- (void)backButtonPressed;

/**
 *  请求列表数据（需重写），需要调用[super requestTableViewDataSource];
 */

- (void)requestTableViewDataSource;
/**
 *  重置返回标题
 */
-(void)resetBackButtonTitleWith:(NSString * )backTitle and:(UIColor *)colorl;


@end

NS_ASSUME_NONNULL_END
