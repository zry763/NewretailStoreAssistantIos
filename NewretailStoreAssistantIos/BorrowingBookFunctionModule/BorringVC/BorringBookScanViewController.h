//
//  BorringBookScanViewController.h
//  NewretailStoreAssistantIos
//
//  Created by Z-Mac on 2019/9/23.
//  Copyright © 2019 zry. All rights reserved.
//借书-2 扫码借阅

#import "BookScanViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface BorringBookScanViewController : BookScanViewController<UIViewControllerTransitioningDelegate>
@property (nonatomic,copy) NSString *strScannedUserId;

@end

NS_ASSUME_NONNULL_END
