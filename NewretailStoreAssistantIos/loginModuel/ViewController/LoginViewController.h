//
//  LoginViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/11.
//  Copyright © 2019 zry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *storeIDField;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneID;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
- (IBAction)passwordVisible:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)loginUserInformation:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *passwordLock;

@end

NS_ASSUME_NONNULL_END
