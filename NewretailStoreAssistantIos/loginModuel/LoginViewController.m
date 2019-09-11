//
//  LoginViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/11.
//  Copyright © 2019 zry. All rights reserved.
//

#import "LoginViewController.h"
#import "TRCColor.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
    


    // Do any additional setup after loading the view.
}
-(void)initSubView{
 
    
    [self.storeIDField.layer addSublayer:[self drawRectCornRadius]];
    [self.userPhoneID.layer addSublayer:[self drawRectCornRadius]];
    [self.userPassword.layer addSublayer:[self drawRectCornRadius]];
    [self.passwordLock setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
    [self.passwordLock setImage:[UIImage imageNamed:@"unLock"] forState:UIControlStateSelected];

}

-(CAShapeLayer *)drawRectCornRadius
{
    CGFloat radius = 22; // 圆角大小
    UIRectCorner corner = UIRectCornerAllCorners; // 圆角位置，全部位置
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.storeIDField.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.storeIDField.bounds;
    maskLayer.path = path.CGPath;
    maskLayer.strokeColor = [TRCColor colorFromHexCode:@"#D4D4D4"].CGColor;
    maskLayer.fillColor = [UIColor whiteColor].CGColor;

    return maskLayer;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*-----------密码是否可见------------*/
- (IBAction)passwordVisible:(id)sender {
//    UIButton *targetBT = (UIButton *)sender;
//    if (targetBT == self.passwordLock) {
    NSLog(@"%@",[NSNumber numberWithBool:self.passwordLock.selected ]);
        self.passwordLock.selected = !self.passwordLock.selected;

//    }
}

/*-----------忘记密码------------*/
- (IBAction)forgotPassword:(id)sender {
    
}
/*-----------登录------------*/
- (IBAction)loginUserInformation:(id)sender {
    
}
@end
