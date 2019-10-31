//
//  BorringInputViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BorringInputViewController.h"
extern NSMutableArray *orderArray;

@interface BorringInputViewController ()
{
    AssistantRequest *vilidRequest;

}
@property (weak, nonatomic) IBOutlet UITextField *bookNums;
- (IBAction)confirmBookNum:(id)sender;
- (IBAction)cancelTheBook:(id)sender;

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
    if (vilidRequest) {
         [vilidRequest cancel];
         vilidRequest = nil;
     }
    
   
    vilidRequest = [AssistantTask libraryManagevlidateWithUserId:self.strScannedUserId goodsSn:self.bookNums.text successBlock:^(TRCResult * _Nonnull goodInfo) {
           if ([goodInfo.output isKindOfClass:[NSString class]]) {
             
             
             if (orderArray.count>0) {
                 for (recordList *order in orderArray) {
                     if ([order.goodsSn isEqualToString:self.bookNums.text]) {
                         order.lendingCount ++;
                     }else
                     {
                         recordList *orderinfo = [[recordList alloc]init];
                         orderinfo.goodsSn = self.bookNums.text;
                         orderinfo.lendingCount = 1;
                         orderinfo.goodSnName = goodInfo.output;
                         [orderArray addObject:orderinfo];
                         
                     }
                 }
             }else
             {
                 recordList *orderinfo = [[recordList alloc]init];
                 orderinfo.goodsSn = self.bookNums.text;
                 orderinfo.lendingCount = 1;
                 orderinfo.goodSnName = goodInfo.output;
                 [orderArray addObject:orderinfo];
                 
             }
             [self dismissViewControllerAnimated:YES completion:nil];
         }
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];

    }];
    
    
 
}
-(void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if (self.orderDelegete) {
           self.orderDelegete();
       }
    
    
    
    
}
- (IBAction)cancelTheBook:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
