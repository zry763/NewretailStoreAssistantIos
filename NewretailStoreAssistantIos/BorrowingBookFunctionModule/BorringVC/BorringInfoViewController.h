//
//  BorringInfoViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BorringInfoViewController : BaseViewController
@property (nonatomic,copy) NSString *strScannedUserId;
@property (weak, nonatomic) IBOutlet UILabel *nikeName;
@property (weak, nonatomic) IBOutlet UIImageView *nikeImage;
@property (weak, nonatomic) IBOutlet UILabel *remmantBorringCount;
@property (weak, nonatomic) IBOutlet UILabel *remainReturnCount;
@property (weak, nonatomic) IBOutlet UILabel *overdueCount;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;
- (IBAction)goNextStep:(id)sender;

@end

NS_ASSUME_NONNULL_END
