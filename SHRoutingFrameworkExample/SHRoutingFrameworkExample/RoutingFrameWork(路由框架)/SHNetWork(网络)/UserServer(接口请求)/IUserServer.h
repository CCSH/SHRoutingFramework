//
//  IUserServer.h
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/7.
//  Copyright © 2018 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IServerBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IUserServer : NSObject

/**
 登录接口

 @param telNo 电话号
 @param passWord 密码
 @param result 回调
 */
+ (void)getLoginWithTelNo:(NSString *)telNo passWord:(NSString *)passWord result:(netWorkBlock)result;

@end

NS_ASSUME_NONNULL_END
