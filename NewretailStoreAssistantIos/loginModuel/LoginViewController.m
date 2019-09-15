//
//  LoginViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/11.
//  Copyright © 2019 zry. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()
@property (strong ,nonatomic) UIView *maskView;

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

-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.64];
    }
    return _maskView;
}

-(void)showLoading:(UIView *)view title:(NSString *)title{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view==nil?[[UIApplication sharedApplication].windows lastObject]:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    UIImageView* mainImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
    hud.customView = mainImageView;
    hud.label.text =title;
    hud.label.textColor = [UIColor whiteColor];
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 2;
    rotationAnimation.repeatCount = HUGE_VALF;
    [mainImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

 
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

    self.userPassword.secureTextEntry = self.passwordLock.selected;
    self.passwordLock.selected = !self.passwordLock.selected;
}

/*-----------忘记密码------------*/
- (IBAction)forgotPassword:(id)sender {
    
    [self.maskView removeFromSuperview];

    
}
/*-----------登录------------*/
- (IBAction)loginUserInformation:(id)sender {

    [self.view addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self showLoading:self.maskView title:@"正在登录"];
    
    [self performSelector:@selector(dismissMaskView) withObject:self afterDelay:3];
    
    
}
-(void)dismissMaskView{
    
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    
}
@end
