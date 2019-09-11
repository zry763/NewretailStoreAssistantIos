//
//  NSArray+Crash.m
//  LawcertFinanceProject
//
//  Created by zry on 2019/8/6.
//  Copyright © 2019 Riku. All rights reserved.
//

#import "NSArray+Crash.h"
#import <objc/runtime.h>

@implementation NSArray (Crash)

+ (void)load
{
    [super load];
    
    //替换不可变数组方法
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtSafeIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    
    Method oldObjectAtIndexSubscript = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
    Method newObjectAtIndexSubscript = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtSafeIndexedSubscript:));
    method_exchangeImplementations(oldObjectAtIndexSubscript, newObjectAtIndexSubscript);
    
    //替换可变数组方法
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtSafeIndex:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
    
    Method oldMutableObjectAtIndexSubscript = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
    Method newMutableObjectAtIndexSubscript =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtSafeIndexSubscript:));
    method_exchangeImplementations(oldMutableObjectAtIndexSubscript, newMutableObjectAtIndexSubscript);
    
}

- (id)objectAtSafeIndex:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self objectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self objectAtSafeIndex:index];
    }
}

- (id)objectAtSafeIndexedSubscript:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self objectAtSafeIndexedSubscript:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self objectAtSafeIndexedSubscript:index];
    }
}
- (id)mutableObjectAtSafeIndex:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self mutableObjectAtSafeIndex:index];
    }
}

- (id)mutableObjectAtSafeIndexSubscript:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtSafeIndexSubscript:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self mutableObjectAtSafeIndexSubscript:index];
    }
}
@end
