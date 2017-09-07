//
//  TXUserModel.m
//  TailorX
//
//  Created by Qian Shen on 24/3/17.
//  Copyright © 2017年 utouu. All rights reserved.
//

#import "TXUserModel.h"
#import "TXModelAchivar.h"
#import <objc/runtime.h>
#import "MJExtension.h"

@implementation TXUserModel

+ (TXUserModel *)defaultUser {
    static TXUserModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [TXModelAchivar unachiveUserModel];
        if (!model) {
            model = [[TXUserModel alloc]init];
            // 默认定位为成都市
            model.longitude = @"104.064095";
            model.latitude = @"30.551882";
        }
    });
    return model;
}

MJCodingImplementation

/**
 * 字典转模型
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    [[TXUserModel defaultUser] setValuesForKeysWithDictionary:dictionary];
    return [TXUserModel defaultUser];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


/**
 * 清楚用户数据
 */
- (void)resetModelData {
    self.isLogin = @"0";
    self.mobile = nil;
    self.userId = nil;
}

/**
 判断用户登录状态
 
 @return true：登录 false：未登录
 */
- (BOOL)userLoginStatus {
    return [[TXModelAchivar getUserModel].isLogin isEqualToString:@"1"];
}

@end
