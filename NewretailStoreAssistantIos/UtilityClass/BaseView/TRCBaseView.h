//
//  TRCBaseView.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 08/11/2016.
//  Copyright © 2016 浙江小泰科技科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRCBaseView : UIView

/**
 *  从nib文件中获取view
 */
+ (instancetype)viewFromNib;

+ (instancetype)viewFromNibName:(NSString *)nibName bundleName:(NSString *)bundleName;

+ (instancetype)viewFromNibWithIndex:(NSInteger)index;

+ (instancetype)viewFromNibName:(NSString *)nibName bundleName:(NSString *)bundleName index:(NSInteger)index;

/**
 *  根据model内容配置view的显示信息
 *
 *  model 模型数据
 */
- (void)setupViewWithModel:(id)model;

@end
