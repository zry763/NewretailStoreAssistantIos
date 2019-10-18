//
//  PageModel.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/10/12.
//  Copyright © 2019 zry. All rights reserved.
//

#import "PageModel.h"

@implementation PageModel

#pragma mark - Lifecycle
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self initData];
    }
    
    return self;
}


#pragma mark - Public Methods
#pragma mark 数据初始化
- (void)initData {
    
    _currPage = 1;
    _pageSize = 10;
}

//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//
//    return @{
//             @"pageSize":@"pageData",
//             @"pageIndex":@"curPage",
//             };
//}
@end
