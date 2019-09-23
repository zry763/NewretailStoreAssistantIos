//
//  BorringProcessView.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BorringProcessView : TRCBaseView
@property (weak, nonatomic) IBOutlet UILabel *firstStep;
@property (weak, nonatomic) IBOutlet UILabel *secondStep;
@property (weak, nonatomic) IBOutlet UILabel *thirdStep;

@end

NS_ASSUME_NONNULL_END
