//
//  IServerBaseModel.h
//  SHRoutingFrameworkExample
//
//  Created by CSH on 2018/12/7.
//  Copyright © 2018 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IServerBaseModel;

//回调
typedef void (^netWorkBlock)(IServerBaseModel *baseModel,NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface IServerBaseModel : NSObject

//请求Code
@property (nonatomic, copy) NSString *code;
//请求文本
@property (nonatomic, copy) NSString *message;
//请求数据
@property (nonatomic, strong) id data;

@end

NS_ASSUME_NONNULL_END
