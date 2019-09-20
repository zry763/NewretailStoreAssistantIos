//
//  THCustomSegmentView.h
//  TaiHeWeb
//
//  Created by 朱封毅 on 08/09/15.
//  Copyright (c) 2015年 律信财富. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^segmentClick) (id segment,NSInteger index);

@interface THCustomSegmentView : UIView

/**
 *  初始化方法
 *
 *  frame      大小和位置
 *  titleArray 标题数组
 *  clickIndex 点击下标
 *
 *  
 */

-(instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray block:(segmentClick) clickIndex;


/**
 *  初始化方法
 *
 *  frame      大小和位置
 *  titleArray 标题数组
 *  clickIndex 点击下标
 *
 *
 */

-(instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray badgeEnable:(BOOL)badgeEnable block:(segmentClick) clickIndex;


/**
 *  初始化方法
 *
 *  frame      大小和位置
 *  titleArray 标题数组
 *  clickIndex 点击下标
 *  autoAdaptTitleLength 是否自适应指示器的宽度
 *
 * 
 */

-(instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray autoAdaptTitleLength:(BOOL) autoAdaptTitleLength block:(segmentClick) clickIndex;



/**
 *  是否含有红点标记
 */
@property(nonatomic,assign) BOOL  badgeEnable;
/**
 *  设置右上角的标记
 *
 *  index 标记的下标
 *  title 标记的文字
 */
#pragma mark Public Method
-(void)setBadgeAtIndex:(NSInteger) index value:(NSString*)value;

/**
 *  更新badge 的方法
 *
 *  index
 *  value 
 */
-(void)updateBadgeAtIndex:(NSInteger)index value:(NSString*) value;

/**
 *  滚动scrollerview 切换
 */
@property(nonatomic,assign)NSInteger index;

/**
 *  设置选择标题数组
 */
@property(nonatomic,strong) NSArray *titleArray;

/**
 *  点击切换block 回调
 */
@property(nonatomic,copy) segmentClick  clickindex;

/**
 *  是否显示底部的黑线
 */
@property(nonatomic,assign) BOOL isShowButtomLine;


/**
 *  默认标题大小,默认14号
 */
@property(nonatomic,strong) UIFont *titlefont;


/**
 *  默认标题颜色
 */
@property(nonatomic,strong)UIColor  *titleNormalColor;

/**
 *  选中标题颜色
 */
@property(nonatomic,strong)UIColor  *titleSelectColor;

/**
 *  指示器的颜色，默认蓝色
 */
@property(nonatomic,strong) UIColor *indictorColor;

/**
 *  指示器高度 默认2像素
 */
@property(nonatomic,assign) float    indictorLineHeight;

/**
 *  自动适配指示器的宽度
 */
@property(nonatomic,assign)BOOL  autoAdaptTitleLength;


@end
