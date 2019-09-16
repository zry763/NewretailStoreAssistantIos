//
//  TRCURLParser.h
//  TRFinanceKit
//
//  Created by 陆佳峰 on 07/11/2016.
//  Copyright © 2016 泰然城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCURLParser : NSObject

/**
 *  This method is the designated initializer for the class.
 *
 *  url incoming URL.
 *
 *  instance of the class.
 */
- (instancetype)initWithURLString:(NSString *)url;

/**
 *  Quering corresponding values of the designated variables.
 *
 *  varName variables name.
 *
 *  value of variable.
 */
- (NSString *)valueForVariable:(NSString *)varName;

@end
