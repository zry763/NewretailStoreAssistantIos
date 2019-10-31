//
//  HXInputViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/20.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HXInputViewController.h"
#import "HXDetailsViewController.h"

@interface HXInputViewController (){
    AssistantRequest *checkCodeRequest;

}
@property (weak, nonatomic) IBOutlet UITextField *inputHXNumberTextFiled;
- (IBAction)confirmHX:(id)sender;
- (IBAction)gobackScanHX:(id)sender;

@end

@implementation HXInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



-(void)setupSubviews{
    [self.inputHXNumberTextFiled.layer addSublayer:[self drawRectCornRadius]];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmHX:(id)sender {
    
    

    if (checkCodeRequest) {
        [checkCodeRequest cancel];
        checkCodeRequest = nil;
        
    }
    checkCodeRequest = [AssistantTask hxCheckItemInfoWithTypeId:self.typeId reservationCode:self.inputHXNumberTextFiled.text successBlock:^(TRCResult *checkResult) {
        NSLog(@"strScanned=%@",self.inputHXNumberTextFiled.text);
        [self resetBackButtonTitleWith:@"预约详情"and:[UIColor clearColor]];
        HXDetailsViewController *hxDetailVC =[[HXDetailsViewController alloc]init];
        hxDetailVC.reservationCode = self.inputHXNumberTextFiled.text;
        hxDetailVC.typeId = self.typeId;
        hxDetailVC.confirmBtDisplay = YES;
        
        [self.navigationController pushViewController:hxDetailVC animated:YES];
        
    } failureBlock:^(TRCResult *result) {
        [self.view makeToast:result.responseContent duration:1 position:CSToastPositionBottom];
        
    }];
    
  
    
}

- (IBAction)gobackScanHX:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//输入框圆角效果
-(CAShapeLayer *)drawRectCornRadius
{
    CGFloat radius = 22; // 圆角大小
    UIRectCorner corner = UIRectCornerAllCorners; // 圆角位置，全部位置
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-2*30, self.inputHXNumberTextFiled.bounds.size.height) byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-2*30, self.inputHXNumberTextFiled.bounds.size.height);
    maskLayer.path = path.CGPath;
    maskLayer.strokeColor = [TRCColor colorFromHexCode:@"#D4D4D4"].CGColor;
    maskLayer.fillColor = [UIColor whiteColor].CGColor;
    
    return maskLayer;
}
@end
