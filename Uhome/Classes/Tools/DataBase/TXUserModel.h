//
//  TXUserModel.h
//  TailorX
//
//  Created by Qian Shen on 24/3/17.
//  Copyright © 2017年 utouu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXUserModel : NSObject

/** 是否登录*/
@property (nonatomic, copy) NSString *isLogin; // 1:已登录 其他：未登录

/*****************************获取用户个人信息-返回*********************************/

/** 用户当前所在的城市 */
@property (nonatomic, strong) NSString *currentCity;
/** 用户当前的经度 */
@property (nonatomic, strong) NSString *longitude;
/** 用户当前的纬度 */
@property (nonatomic, strong) NSString *latitude;


/** 悠唐昵称 */
@property (nonatomic, strong) NSString *user_name;
/** 客户联系电话 */
@property (nonatomic, strong) NSString *mobile;
/** 客户联系电话 */
@property (nonatomic, strong) NSString *userId;
/** 客户联系电话 */
@property (nonatomic, strong) NSString *point;

+ (TXUserModel *)defaultUser;

/**
 * 清楚用户数据
 */
- (void)resetModelData;

/**
 * 字典转模型
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 判断用户登录状态

 @return true：登录 false：未登录
 */
- (BOOL)userLoginStatus;


@end
