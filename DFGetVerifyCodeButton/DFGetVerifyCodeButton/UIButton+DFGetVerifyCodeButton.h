//
//  UIButton+DFGetVerifyCodeButton.h
//  DFGetVerifyCodeButton
//
//  Created by WANG Haojiao on 2017/7/22.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DFVerifyCodeEnumerationBlock)(NSInteger);
typedef void (^DFVerifyCodeCompletionBlock)();

@interface UIButton (DFGetVerifyCodeButton)

- (void)startCountDownWithSeconds:(NSInteger)second eachSecondEnunmeration:(DFVerifyCodeEnumerationBlock)enumeration andCompletion:(DFVerifyCodeCompletionBlock)completion;
- (void)startCountDownWithSeconds:(NSInteger)second withGlobalKey:(NSString*)key eachSecondEnunmeration:(DFVerifyCodeEnumerationBlock)enumeration andCompletion:(DFVerifyCodeCompletionBlock)completion;

@property (nonatomic,strong) NSTimer* df_timer;
@property (nonatomic,strong) NSDate* df_endDate;

@end
