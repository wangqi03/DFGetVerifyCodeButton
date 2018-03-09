//
//  DFVerifyCodeGlobalDispatcher.h
//  DFGetVerifyCodeButton
//
//  Created by wanghaojiao on 2018/3/9.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "UIButton+DFGetVerifyCodeButton.h"

@interface DFVerifyCodeGlobalDispatcher : NSObject

+ (instancetype)dispatcher;

- (void)registerGlobalCountDownButton:(UIButton*)button
                         forKey:(NSString*)key;

- (UIButton*)globalCountDownButtonForKey:(NSString*)key;

- (void)recoverCountDownBehaviourOfKey:(NSString*)key
                              toButton:(UIButton*)button
                eachSecondEnunmeration:(DFVerifyCodeEnumerationBlock)enumeration
                         andCompletion:(DFVerifyCodeCompletionBlock)completion;

@end
