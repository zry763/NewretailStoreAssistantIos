//
//  YYListTableViewCell.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^YYlistProjectIndex)(NSInteger index);
typedef void(^YYHXProjectIndex)(NSInteger index);

@interface YYListTableViewCell : BaseTableViewCell

@property (copy ,nonatomic) YYlistProjectIndex yylistProject;
@property (copy ,nonatomic) YYHXProjectIndex yyHXProject;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

/**
 * 预约项目名称
 */
@property (weak, nonatomic) IBOutlet UILabel *yyProjectTitle;
/**
 * 累计预约数量
 */
@property (weak, nonatomic) IBOutlet UILabel *yySummuryCount;
/**
 * 待核销数量
 */
@property (weak, nonatomic) IBOutlet UILabel *dhxCount;
/**
 * 已核销数量
 */
@property (weak, nonatomic) IBOutlet UILabel *yhxCount;
/**
 * 核销按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *goHxButton;
/**
 * 预约项目列表
 */
- (IBAction)getYYlistForProjectIndex:(id)sender;
/**
 * 去核销的项目
 */
- (IBAction)goHxForProjectIndex:(id)sender;
@end

NS_ASSUME_NONNULL_END
