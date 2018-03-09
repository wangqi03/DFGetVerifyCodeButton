//
//  UIButton+DFGetVerifyCodeButton.m
//  DFGetVerifyCodeButton
//
//  Created by WANG Haojiao on 2017/7/22.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "UIButton+DFGetVerifyCodeButton.h"
#import <objc/runtime.h>
#import "DFVerifyCodeGlobalDispatcher.h"

#define DF_SECONDS_TO_COUNT_DOWN_RUNTIME_KEY "DF_SECONDS_TO_COUNT_DOWN_RUNTIME_KEY"
#define DF_COUNT_DOWN_TIMER_RUNTIME_KEY "DF_COUNT_DOWN_TIMER_RUNTIME_KEY"

@interface DFVerifyCodeButtonPasser : NSObject
@property (nonatomic,strong) DFVerifyCodeCompletionBlock completion;
@property (nonatomic,strong) DFVerifyCodeEnumerationBlock enumeration;
@end

@implementation UIButton (DFGetVerifyCodeButton)

- (void)startCountDownWithSeconds:(NSInteger)second eachSecondEnunmeration:(DFVerifyCodeEnumerationBlock)enumeration andCompletion:(DFVerifyCodeCompletionBlock)completion {
    [self startCountDownWithSeconds:second withGlobalKey:nil eachSecondEnunmeration:enumeration andCompletion:completion];
}

- (void)startCountDownWithSeconds:(NSInteger)second withGlobalKey:(NSString *)key eachSecondEnunmeration:(DFVerifyCodeEnumerationBlock)enumeration andCompletion:(DFVerifyCodeCompletionBlock)completion {
    [self.df_timer invalidate];
    self.df_timer = nil;
    self.df_endDate = [NSDate dateWithTimeIntervalSinceNow:second];
    
    //    self.userInteractionEnabled = NO;
    enumeration((NSInteger)[self.df_endDate timeIntervalSinceNow]);
    
    DFVerifyCodeButtonPasser* passer = [[DFVerifyCodeButtonPasser alloc] init];
    passer.completion = completion;
    passer.enumeration = enumeration;
    
    self.df_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:passer repeats:YES];
    
    if (key.length) {
        [[DFVerifyCodeGlobalDispatcher dispatcher] registerGlobalCountDownButton:self forKey:key];
    }
}

- (void)countDown:(NSTimer*)timer {
    DFVerifyCodeButtonPasser* passer = timer.userInfo;
    if ([self.df_endDate timeIntervalSinceNow]>0) {
        passer.enumeration((NSInteger)([self.df_endDate timeIntervalSinceNow]));
    } else {
        passer.completion();
//        self.userInteractionEnabled = YES;
        [self.df_timer invalidate];
        self.df_timer = nil;
    }
}

- (NSDate*)df_endDate {
    return objc_getAssociatedObject(self, DF_SECONDS_TO_COUNT_DOWN_RUNTIME_KEY);
}

- (void)setDf_endDate:(NSDate*)df_endDate {
    objc_setAssociatedObject(self, DF_SECONDS_TO_COUNT_DOWN_RUNTIME_KEY, df_endDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer*)df_timer {
    return objc_getAssociatedObject(self, DF_COUNT_DOWN_TIMER_RUNTIME_KEY);
}

- (void)setDf_timer:(NSTimer*)timer {
    objc_setAssociatedObject(self, DF_COUNT_DOWN_TIMER_RUNTIME_KEY, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation DFVerifyCodeButtonPasser
@end
