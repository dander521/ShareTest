//
//  TXCountDownTime.h
//  TailorX
//
//  Created by Qian Shen on 23/4/17.
//  Copyright © 2017年 utouu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - SingleTon
/*****************************************SingleTon***********************************************/
// 单例化一个类
// @interface
#define singleton_interface(className) \
+ (className *)shared##className;

// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}
/*****************************************SingleTon***********************************************/

@interface TXCountDownTime : NSObject

/**
 开启倒计时
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color atBtn:(UIButton*)btn;
/**
 停止倒计时
 */
- (void)stopCountDownTimeAtBtn:(UIButton*)btn;

singleton_interface(TXCountDownTime)

@end
