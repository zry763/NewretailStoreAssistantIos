//
//  OrderInfoPresentationController.h
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderInfoPresentationController : UIPresentationController<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIView *dimmingView;

@end

NS_ASSUME_NONNULL_END
