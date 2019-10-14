//
//  LoginViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/11.
//  Copyright © 2019 zry. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "UserInfoModel.h"
/*
 *  在手机输入框中插入第一个空格的
 */
#define INPUT_INSERT_SPACE_MIN      4

/*
 *  在手机输入框中插入第二个空格的
 */
#define INPUT_INSERT_SPACE_MIDDLE   9

/*
 *  在手机输入框中插入第三个空格的
 */
#define INPUT_INSERT_SPACE_MAX      13
@interface LoginViewController ()
@property (strong ,nonatomic) UIView *maskView;
@property (nonatomic,assign) BOOL isValidInputText;
@property (weak, nonatomic) IBOutlet UIButton *loginBT;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarHidden = YES;



    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.storeIDField.layer addSublayer:[self drawRectCornRadius]];
    [self.userPhoneID.layer addSublayer:[self drawRectCornRadius]];
    [self.userPassword.layer addSublayer:[self drawRectCornRadius]];
}

- (void)setupSubviews {
    [self.passwordLock setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
    [self.passwordLock setImage:[UIImage imageNamed:@"unLock"] forState:UIControlStateSelected];
    [self.loginBT setEnabled:YES];
}


//输入框圆角效果
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
//蒙版
-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.64];
    }
    return _maskView;
}

//加载动画效果展示
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
    rotationAnimation.duration = 4;
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
//密码是否可见
- (IBAction)passwordVisible:(id)sender {

    self.userPassword.secureTextEntry = self.passwordLock.selected;
    self.passwordLock.selected = !self.passwordLock.selected;
}
//忘记密码
- (IBAction)forgotPassword:(id)sender {
    
    
    [self.view makeToast:@"请联系管理员" duration:3 position:CSToastPositionBottom];

    
}
//登录
- (IBAction)loginUserInformation:(id)sender {
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *destVC = [main instantiateInitialViewController];
    destVC.modalPresentationStyle =  UIModalPresentationFullScreen;
//    if ([[self endEditTextFiled:self.storeIDField] isEqualToString:@""]) {
//          [self.view makeToast:@"请输入门店编号" duration:1 position:CSToastPositionCenter];
//          return;
//
//      }
//    if ([[self endEditTextFiled:self.userPhoneID] isEqualToString:@""]) {
//        [self.view makeToast:@"请输入电话号码" duration:1 position:CSToastPositionCenter];
//        return;
//    }
//    if ([[self endEditTextFiled:self.userPassword] isEqualToString:@""]) {
//        [self.view makeToast:@"请输入密码" duration:1 position:CSToastPositionCenter];
//        return;
//
//    }
  

    
    [AssistantTask loginWithPhoneNumber:@"admin" password:@"admin@123" storeID:@"3462566" successBlock:^(UserInfoModel * _Nonnull infoModel) {
        
        
        [self.navigationController presentViewController:destVC animated:YES completion:nil];

        
    } failureBlock:^(TRCResult *result) {
        
        [self.view makeToast:@"请联系管理员" duration:3 position:CSToastPositionCenter];

    }];
    

//    [self.view addSubview:self.maskView];
//    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//
//    [self showLoading:self.maskView title:@"正在登录"];
//
//    [self performSelector:@selector(dismissMaskView) withObject:self afterDelay:3];
    
    
}

-(void)dismissMaskView{
    
    [self.maskView removeFromSuperview];
    self.maskView = nil;
}


// 转化手机输入框的文本显示格式
- (NSString *)changePhoneForInputTextField:(NSString *)string {
    if ([TRCStringUtil isEmpty:string]) { // 为空直接返回
        return nil;
    }
    NSString *result = nil;
    NSString *space = @" ";
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    [mutableString appendString:string];
    NSInteger stringLength = [mutableString length];
    
    NSMutableString *newString = [[string stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    if ([newString length] == INPUT_PHONE_NUMBER_LENGTH) {
        
        [newString insertString:space atIndex:INPUT_INSERT_SPACE_MIN - 1];
        [newString insertString:space atIndex:INPUT_INSERT_SPACE_MIDDLE - 1];
        return newString;
    }
    
    if (stringLength == INPUT_INSERT_SPACE_MIN || stringLength == INPUT_INSERT_SPACE_MIDDLE ) {
        NSString *spaceStr = [mutableString substringWithRange:NSMakeRange(stringLength-1, 1)];
        NSLog(@"space text = %@",spaceStr);
        if([spaceStr isEqualToString:@" "]) {
            [mutableString deleteCharactersInRange:NSMakeRange(stringLength-1, 1)];
        }
        else {
            [mutableString insertString:space atIndex:stringLength-1];
        }
        result = mutableString;
    } else if (stringLength > INPUT_INSERT_SPACE_MAX ){
        result = [mutableString substringWithRange:NSMakeRange(0, INPUT_INSERT_SPACE_MAX)];
    } else {
        result = mutableString;
    }
    
    NSLog(@"result = %@",result);
    return result;
}

- (NSString *)endEditTextFiled:(UITextField *)desText {
    return [desText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString * newString = [NSMutableString stringWithString:textField.text];
    [newString replaceCharactersInRange:range withString:string];
    if (textField == self.userPhoneID) {
        
    if ([newString length] > INPUT_PHONE_NUMBER_LENGTH + 2){
        self.isValidInputText = NO;
        return NO;
    }
    
    // 转换手机号码的输入显示格式  中间加空格
    self.userPhoneID.text = [self changePhoneForInputTextField:textField.text];
    
    if (newString.length >= 0 && newString.length <= INPUT_PHONE_NUMBER_LENGTH + 2) {
        self.isValidInputText = YES;
    } else {
        self.isValidInputText = NO;
    }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (![TRCStringUtil isEmpty:self.userPhoneID.text]&& ![TRCStringUtil isEmpty:self.userPassword.text] &&![TRCStringUtil isEmpty:self.storeIDField.text]) {
        self.loginBT.enabled = YES;
        [self.loginBT setBackgroundColor:[TRCColor colorFromHexCode:@"#D33A31"]];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
