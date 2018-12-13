//
//  SHRoutingTool.h
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/7.
//  Copyright © 2018 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>

//跳转类型
typedef enum : NSUInteger {
    SHJumpType_push,            //nav push跳转
    SHJumpType_model,           //无nav 模型跳转
    SHJumpType_pop,             //返回上一级界面(有nav就pop 没有就dissmiss)
    SHJumpType_specify,         //跳转指定界面
    SHJumpType_pop_root,        //返回根界面
} SHJumpType;

//回调
typedef void(^Block)(NSDictionary *parameter);

NS_ASSUME_NONNULL_BEGIN

@interface SHRoutingTool : NSObject

//打开界面
+ (void)openUrlWithUrl:(NSString *)url parameter:(NSDictionary *)parameter jumpType:(SHJumpType)jumpType block:(Block)block;

//获取参数
+ (NSDictionary *)getParameterWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
