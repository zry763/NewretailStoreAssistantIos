//
//  THCustomSegmentView.m
//  TaiHeWeb
//
//  Created by 朱封毅 on 08/09/15.
//  Copyright (c) 2015年 律信财富. All rights reserved.
//

#import "THCustomSegmentView.h"
#import "THBageLabl.h"
#import "UIView+TRCViewUtils.h"


#define BUTTON_TAG  100

//指示器的时间
#define INDICTIOR_INTERVAL 0.3

#define BUTTON_SELECT_TITLE_COLOR [UIColor colorWithRed:35.0/255 green:142.0/255 blue:222.0/255 alpha:1]

#define BUTTON_NORMAL_TITLE_COLOR [UIColor colorWithRed:109.0/255 green:109.0/255 blue:109.0/255 alpha:1]

#define INDICTIORVIEW_COLOR [UIColor colorWithRed:35.0/255 green:142.0/255 blue:222.0/255 alpha:1]


@interface THCustomSegmentView ()

/**
 *    移动指示器
 */
@property(nonatomic,strong) UIView  *indictorView;

/**
 *  底部的黑线
 */
@property(nonatomic,strong) UIView  *bottomlineView;

@end


@implementation THCustomSegmentView

#pragma mark - LifeCyle
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setDefualtValues];
    }
    return self;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setDefualtValues];
}


#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray block:(segmentClick)clickIndex{
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        [self setDefualtValues];
        
        self.titleArray = titleArray;
        
        self.clickindex = clickIndex;
        
        self.autoAdaptTitleLength = NO;
        
    }
    
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray badgeEnable:(BOOL)badgeEnable block:(segmentClick) clickIndex {
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.badgeEnable = badgeEnable;
        [self setDefualtValues];
        
        self.titleArray = titleArray;
        self.clickindex = clickIndex;
        self.autoAdaptTitleLength = NO;
        
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray autoAdaptTitleLength:(BOOL) autoAdaptTitleLength block:(segmentClick) clickIndex {
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        self.autoAdaptTitleLength = autoAdaptTitleLength;
        
        [self setDefualtValues];
        
        self.titleArray = titleArray;
        
        self.clickindex = clickIndex;
        
    }
    
    return self;
}


#pragma mark Privite Method
-(void)setupView{
    
    float btnWidth = self.frame.size.width/self.titleArray.count;
    //create buttons
    for (int i =0; i < self.titleArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, self.frame.size.height);
        btn.tag = BUTTON_TAG +i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.titleSelectColor forState:UIControlStateSelected];
        [btn setTitleColor:self.titleSelectColor forState:UIControlStateHighlighted];
        
        btn.titleLabel.font = self.titlefont;
        [self addSubview:btn];
        
        if (i==0) {
            btn.selected =YES;
        }
        
        if (self.badgeEnable) {
            
            THBageLabl *lbl = [[THBageLabl alloc] initWithFrame:CGRectZero];
            [btn addSubview:lbl];
        }
        
    }
    //createline
    
    float insetWidth = btnWidth - (4/self.titleArray.count)*40;
    
    if (self.autoAdaptTitleLength) {
        
        NSString *title0  = [self.titleArray objectAtIndex:0];
        CGFloat titlewidth = [title0 boundingRectWithSize:CGSizeMake(200, 60) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.titlefont} context:nil].size.width;
        insetWidth = titlewidth + 10;
        
    }
    
    self.indictorView = [[UIView alloc] initWithFrame:CGRectMake((4/self.titleArray.count*40)/2,self.frame.size.height-2, insetWidth, 2)];
    self.indictorView.backgroundColor = self.indictorColor;
    [self addSubview:self.indictorView];
    
    UIButton *button = (UIButton*)[self viewWithTag:BUTTON_TAG+0];

    self.indictorView.centerX=button.centerX;
    
    self.bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.3, self.frame.size.width, 0.3)];
    self.bottomlineView.backgroundColor = [UIColor colorWithRed:228.0/255 green:228.0/255 blue:228.0/255 alpha:1];
    [self addSubview:self.bottomlineView];
    
}


#pragma mark 按钮点击事件
-(void)btnClick:(UIButton *) btn
{
    
    if (btn.selected ==YES) {
        return;
    }
    
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:BUTTON_TAG+i];
        button.selected = NO;
    }
    btn.selected = YES;
    
    _index = btn.tag - BUTTON_TAG;
    [UIView animateWithDuration:INDICTIOR_INTERVAL animations:^{
        
        if (self.autoAdaptTitleLength) {
            
            
            NSString *title  = [self.titleArray objectAtIndex:_index];
            
            CGFloat titlewidth = [title boundingRectWithSize:CGSizeMake(200, 60) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
            
            self.indictorView.width = titlewidth+10;
            
            self.indictorView.centerX = btn.centerX;
            
            
        }else{
            self.indictorView.centerX = btn.centerX;
            
        }
        
    } completion:^(BOOL finished) {
        
        self.clickindex(self, _index);
    }];
}


#pragma mark 初始化
-(void)setDefualtValues
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.isShowButtomLine = YES;
    
    self.titlefont = [UIFont systemFontOfSize:14];
    
    self.titleNormalColor = BUTTON_NORMAL_TITLE_COLOR;
    
    self.titleSelectColor = BUTTON_SELECT_TITLE_COLOR;
    
    self.indictorColor = INDICTIORVIEW_COLOR;
    
    self.indictorLineHeight = 2.f;
    
}



/**
 *  设置badge
 *
 *  badgeEnable
 */
-(void)setBadgeEnable:(BOOL)badgeEnable{
    
    _badgeEnable = badgeEnable;
}

#pragma mark 设置红色标记
-(void)setBadgeAtIndex:(NSInteger) index value:(NSString*)value;
{
    
    UIButton *btn = (UIButton*)[self viewWithTag:BUTTON_TAG+index];
    
    for (UIView  *v in   btn.subviews) {
        if ([v isKindOfClass:[THBageLabl class]]) {
            
            if ([value integerValue]>99) {
                value = @"99+";
            }
            
            
            THBageLabl *badgelble = (THBageLabl*)v;
            
            badgelble.hidden = NO;
            
            /**
             *  设置badgeview 的位置
             */
            NSString *btntitle = [self.titleArray objectAtIndex:index];
            
            float titlewidth = [btntitle boundingRectWithSize:CGSizeMake(100, 15) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
            
            float x =btn.frame.size.width/2 + titlewidth/2 + 4;
            
            float y = 15;
            
            float h = 16;
            float w = 6;
            h = 6;
            badgelble.frame = CGRectMake(x, y, w, h);
            
            if ([value isEqualToString:@""] || [value isKindOfClass:[NSNull class]]||[value isEqualToString:@"0"]) {
                
                badgelble.frame = CGRectMake(x, y, 0, 0);
            }
            
            badgelble.text = value;
            
            
        }
    }
    
}

#pragma mark 更新badge的方法
-(void)updateBadgeAtIndex:(NSInteger)index value:(NSString*) value;
{
    
    [self setBadgeAtIndex:index value:value];
}






#pragma mark  Setter Method
#pragma mark 设置titlearray

//滚动scorlleview的时候，切换item 选中下标
-(void)setIndex:(NSInteger)index{
    
    _index = index;
    
    UIButton *btn = (UIButton*)[self viewWithTag:BUTTON_TAG+index];
    
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:BUTTON_TAG+i];
        button.selected = NO;
    }
    
    btn.selected = YES;
    
    [UIView animateWithDuration:INDICTIOR_INTERVAL animations:^{
        
        if (self.autoAdaptTitleLength) {
            
            
            NSString *title  = [self.titleArray objectAtIndex:_index];
            
            CGFloat titlewidth = [title boundingRectWithSize:CGSizeMake(200, 60) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
            
            self.indictorView.width = titlewidth+10;
            
            self.indictorView.centerX = btn.centerX;
            
            
        }else{
            self.indictorView.centerX = btn.centerX;
            
        }
        
        
    } completion:^(BOOL finished) {
        
        self.clickindex(self, _index);
        
    }];
}

-(void)setIsShowButtomLine:(BOOL)isShowButtomLine
{
    
    _isShowButtomLine = isShowButtomLine;
    
    if (!_isShowButtomLine) {
        
        self.bottomlineView.hidden = YES;
        
    }
}

-(void)setTitleArray:(NSArray *)titleArray{
    
    _titleArray = titleArray;
    
    for (UIView *subview in self.subviews) {
        
        [subview removeFromSuperview];
    }
    
    [self setupView];
}


#pragma mark 设置标题字体

-(void)setTitlefont:(UIFont *)titlefont
{
    _titlefont = titlefont;
    
    for (int i=0; i<self.titleArray.count; i++) {
        
        UIButton *button = (UIButton*)[self viewWithTag:BUTTON_TAG+i];
        
        button.titleLabel.font  = titlefont;
    }
}

#pragma mark 默认标题颜色
-(void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    
    for (int i=0; i<self.titleArray.count; i++) {
        
        UIButton *button = (UIButton*)[self viewWithTag:BUTTON_TAG+i];
        
        [button setTitleColor:titleNormalColor forState:UIControlStateNormal];
        
    }
    
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor
{
    
    _titleSelectColor = titleSelectColor;
    
    for (int i=0; i<self.titleArray.count; i++) {
        
        UIButton *button = (UIButton*)[self viewWithTag:BUTTON_TAG+i];
        [button setTitleColor:titleSelectColor forState:UIControlStateSelected];
        
    }
}
#pragma mark 设置默认的指示器的颜色

-(void)setIndictorColor:(UIColor *)indictorColor{
    
    _indictorColor = indictorColor;
    self.indictorView.backgroundColor  = indictorColor;
    
}

#pragma mark 设置指示器的高度

-(void)setIndictorLineHeight:(float)indictorLineHeight
{
    _indictorLineHeight = indictorLineHeight;
    
    self.indictorView.frame = CGRectMake(0, self.frame.size.height-indictorLineHeight, self.frame.size.width/self.titleArray.count, indictorLineHeight);
    
}

-(void)setAutoAdaptTitleLength:(BOOL)autoAdaptTitleLength
{
    _autoAdaptTitleLength = autoAdaptTitleLength;
    
}
@end
