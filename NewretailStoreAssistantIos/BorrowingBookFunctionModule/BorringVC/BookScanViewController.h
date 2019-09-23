//
//  BookScanViewController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//图书借还扫码界面

#import "BaseScanViewController.h"
#import "StepModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookScanViewController : BaseScanViewController
@property (strong ,nonatomic) StepModel   *stepModel;
@property (assign ,nonatomic) BOOL  borringOrReturn;
@property (assign ,nonatomic) NSInteger  stepNum;


@end

NS_ASSUME_NONNULL_END
