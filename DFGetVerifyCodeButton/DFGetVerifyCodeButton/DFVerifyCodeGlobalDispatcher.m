//
//  DFVerifyCodeGlobalDispatcher.m
//  DFGetVerifyCodeButton
//
//  Created by wanghaojiao on 2018/3/9.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "DFVerifyCodeGlobalDispatcher.h"

@interface DFVerifyCodeGlobalDispatcher()
@property (nonatomic,strong) NSMutableDictionary* dict;
@end

@implementation DFVerifyCodeGlobalDispatcher

+ (instancetype)dispatcher {
    static DFVerifyCodeGlobalDispatcher* _dispatcher;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dispatcher = [[self alloc] init];
    });
    return _dispatcher;
}

- (void)registerGlobalCountDownButton:(UIButton *)button forKey:(NSString *)key {
    
    [[self globalCountDownButtonForKey:key].df_timer invalidate];
    [self globalCountDownButtonForKey:key].df_timer = nil;
    
    [self.dict setObject:button forKey:key];
}

- (UIButton*)globalCountDownButtonForKey:(NSString *)key {
    UIButton* button = [self.dict objectForKey:key];
    if (button&&[button.df_endDate timeIntervalSinceNow]<=0) {
        [self.dict removeObjectForKey:key];
        return nil;
    } else {
        return button;
    }
}

- (void)recoverCountDownBehaviourOfKey:(NSString *)key toButton:(UIButton *)button eachSecondEnunmeration:(DFVerifyCodeEnumerationBlock)enumeration andCompletion:(DFVerifyCodeCompletionBlock)completion {
    UIButton* registeredButton = [self globalCountDownButtonForKey:key];
    if (!registeredButton) {
        if (completion) {
            completion();
        }
        return;
    }
    
    [button startCountDownWithSeconds:[registeredButton.df_endDate timeIntervalSinceNow] withGlobalKey:key eachSecondEnunmeration:enumeration andCompletion:completion];
}

- (NSMutableDictionary*)dict {
    if (!_dict) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    return _dict;
}

@end
