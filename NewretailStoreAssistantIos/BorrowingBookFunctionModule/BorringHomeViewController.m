//
//  BorringHomeViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/20.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringHomeViewController.h"

@interface BorringHomeViewController ()

@end

@implementation BorringHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)borringBook:(id)sender {
    
    UITapGestureRecognizer *gest = (UITapGestureRecognizer *)sender;
    
    UIView *desView = gest.view;
    NSLog(@"%ld",(long)desView.tag);
    
}
@end
