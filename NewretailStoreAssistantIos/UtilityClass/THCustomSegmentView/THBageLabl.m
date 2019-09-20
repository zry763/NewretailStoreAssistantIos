//
//  THBageLabl.m
//  TaiHeCommonKit
//
//  Created by 朱封毅 on 12/11/15.
//  Copyright (c) 2015年 TaiHe. All rights reserved.
//

#import "THBageLabl.h"

@implementation THBageLabl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 16);
        self.backgroundColor = [UIColor colorWithRed:242.0/255 green:90.0/255 blue:43.0/255 alpha:1];
        self.textColor = [UIColor whiteColor];
        
        self.font = [UIFont systemFontOfSize:0];
        
        self.textAlignment = NSTextAlignmentCenter;
        
        self.layer.cornerRadius = 3;
        
        self.clipsToBounds = YES;
        
    }
    return self;
}

@end
