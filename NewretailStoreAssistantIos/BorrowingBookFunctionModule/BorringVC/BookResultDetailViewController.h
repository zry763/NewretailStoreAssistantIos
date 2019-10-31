//
//  BookDetailViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookResultDetailViewController : BaseViewController
@property (nonatomic , copy) NSString *lendCount;
@property (nonatomic , copy) NSString *renturnTime;

@property (weak, nonatomic) IBOutlet UILabel *finalResult;
@property (weak, nonatomic) IBOutlet UIView *bookContainView;
@property (weak, nonatomic) IBOutlet UIButton *goonBorringBT;
@property (weak, nonatomic) IBOutlet UIButton *goHomeBT;
- (IBAction)goonBorringBook:(id)sender;
- (IBAction)goHomeView:(id)sender;




@end

NS_ASSUME_NONNULL_END
