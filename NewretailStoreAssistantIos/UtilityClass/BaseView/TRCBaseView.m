//
//  TRCBaseView.m
//  TRFinanceKit
//
//  Created by 陆佳峰 on 08/11/2016.
//  Copyright © 2016 浙江小泰科技科技有限公司. All rights reserved.
//

#import "TRCBaseView.h"

@implementation TRCBaseView

+ (instancetype)viewFromNib {
    
    return [self viewFromNibWithIndex:0];
}


+ (instancetype)viewFromNibName:(NSString *)nibName bundleName:(NSString *)bundleName {
    
    return [self viewFromNibName:nibName bundleName:bundleName index:0];
}



+ (instancetype)viewFromNibWithIndex:(NSInteger)index {
    
    NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    
    if ([nibs count] <= index) {
        
        return nil;
    }
    
    id view = [nibs objectAtIndex:index];
    
    if (!view) {
        
        return nil;
    }
    
    return view;
}


+ (instancetype)viewFromNibName:(NSString *)nibName bundleName:(NSString *)bundleName index:(NSInteger)index {
    
    NSURL *bundlePathURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    
    if (!bundlePathURL) {
        
        NSLog(@"Can't find【%@.bundle】", bundleName);
    }
    
    NSBundle *bundle = [NSBundle bundleWithURL:bundlePathURL];
    
    NSArray * nibs = [bundle loadNibNamed:nibName owner:self options:nil];
    
    if ([nibs count] <= index) {
        
        return nil;
    }
    
    id view = [nibs objectAtIndex:index];
    
    if (!view) {
        
        return nil;
    }
    
    return view;
}


- (void)setupViewWithModel:(id)model {
    
}

@end
