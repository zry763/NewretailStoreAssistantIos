//
//  UIViewController+backItemTitle.m
//  Test123
//
//  Created by zry on 2019/9/10.
//  Copyright © 2019 zry. All rights reserved.
//

#import "UIViewController+backItemTitle.h"
#import <objc/runtime.h>

@implementation UIViewController (backItemTitle)

+(void)load{
    
    
    
    //替换不可变数组方法
    Method oldObjectMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method newObjectMethod = class_getInstanceMethod([self class], @selector(viewDidLoadSetBackItem));
    method_exchangeImplementations(oldObjectMethod, newObjectMethod);
    
    
}
-(void)viewDidLoadSetBackItem{
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem.backBarButtonItem  setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:18]} forState:UIControlStateNormal];
    [self viewDidLoadSetBackItem];
    
}
@end
