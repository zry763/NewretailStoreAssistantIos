//
//  BorringInputViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringInputViewController.h"

@interface BorringInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bookNums;
- (IBAction)confirmBookNum:(id)sender;

@end

@implementation BorringInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bookNums.layer.cornerRadius = 22;
    self.bookNums.layer.masksToBounds = YES;
    self.bookNums.layer.borderColor = [TRCColor colorFromHexCode:@"#D4D4D4"].CGColor;
    self.bookNums.layer.borderWidth = 1;
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmBookNum:(id)sender {
    //返回扫码借书
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
